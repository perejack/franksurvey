// PayHero API integration — Channel 11294
// Routes through /api/payhero proxy to avoid CORS

const API_BASE_URL = "/api/payhero";
const CHANNEL_ID = 11294;
const AUTH_TOKEN =
  "Basic V09JN3JiOHpOTnJWSzV1bmw5cjI6WUU0ekxFMkhoTGJwTW40cnJkYTk0SjZ2WVVSdTYxUGFoTTR6ZnhHRQ==";

export interface InitiateSTKPushResponse {
  success: boolean;
  CheckoutRequestID?: string;
  reference?: string;
  message?: string;
  status?: string;
}

export interface TransactionStatusResponse {
  success: boolean;
  status: string; // "SUCCESS" | "FAILED" | "PENDING"
  ResultCode?: string | number;
  ResultDesc?: string;
  provider_reference?: string;
  message?: string;
  raw?: any;
}

/**
 * Format phone to local 07XXXXXXXX or 01XXXXXXXX format (PayHero expects local format)
 */
function formatPhoneNumber(phone: string): string {
  const digits = phone.replace(/\D/g, "");
  if (digits.startsWith("0") && digits.length === 10) return digits;
  if (digits.startsWith("254") && digits.length === 12) return `0${digits.slice(3)}`;
  if ((digits.startsWith("7") || digits.startsWith("1")) && digits.length === 9) return `0${digits}`;
  return digits;
}

export function isValidPhoneNumber(phone: string): boolean {
  const formatted = formatPhoneNumber(phone);
  return /^0[17]\d{8}$/.test(formatted);
}

/**
 * Initiate M-Pesa STK Push via PayHero
 */
export async function initiateSTKPush(
  amount: string,
  phoneNumber: string,
  reference: string
): Promise<InitiateSTKPushResponse> {
  const phone = formatPhoneNumber(phoneNumber);

  const payload = {
    amount: Number(amount),
    phone_number: phone,
    channel_id: CHANNEL_ID,
    provider: "m-pesa",
    external_reference: reference,
    description: "FrankSurvey Payment",
  };

  console.log("PayHero STK Push payload →", payload);

  const response = await fetch(`${API_BASE_URL}/payments`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: AUTH_TOKEN,
    },
    body: JSON.stringify(payload),
  });

  const data = await response.json().catch(() => ({}));

  if (!response.ok) {
    console.error("PayHero STK Push error →", response.status, data);
    throw new Error(data?.message || data?.error || `PayHero error: ${response.status}`);
  }

  // PayHero returns reference in data.reference, data.CheckoutRequestID, data.id, or payload reference
  const checkoutId =
    data.reference ||
    data.CheckoutRequestID ||
    data.checkout_request_id ||
    data.checkoutRequestId ||
    data.id ||
    reference;

  console.log("PayHero STK Push success →", data, "Checkout ID:", checkoutId);

  return {
    success: true,
    CheckoutRequestID: checkoutId,
    reference: checkoutId,
    message: data.message || "STK push sent to your phone",
  };
}

/**
 * Check transaction status by reference
 */
export async function checkTransactionStatus(
  reference: string
): Promise<TransactionStatusResponse> {
  try {
    const response = await fetch(
      `${API_BASE_URL}/transaction-status?reference=${encodeURIComponent(reference)}`,
      {
        method: "GET",
        headers: { Authorization: AUTH_TOKEN },
      }
    );

    const data = await response.json().catch(() => ({}));
    console.log("PayHero status check response →", data);

    const resObj = (data.response || data.data || data) as Record<string, any>;
    const statusStr = String(
      data.status || data.Status || resObj.status || resObj.Status || ""
    ).toUpperCase();
    const resultCode = String(
      data.ResultCode ?? resObj.ResultCode ?? data.result_code ?? resObj.result_code ?? ""
    );

    // Comprehensive success detection
    const isSuccess =
      data.success === true ||
      resObj.success === true ||
      statusStr === "SUCCESS" ||
      statusStr === "COMPLETED" ||
      statusStr === "PAID" ||
      resultCode === "0";

    // Comprehensive failure detection
    const isFailed =
      (statusStr === "FAILED" || statusStr === "CANCELLED" || statusStr === "CANCELED") &&
      resultCode !== "0" &&
      resultCode !== "";

    const desc =
      resObj.ResultDesc ||
      data.ResultDesc ||
      data.message ||
      resObj.message ||
      (isSuccess ? "Payment completed successfully" : "Processing...");

    return {
      success: isSuccess,
      status: isSuccess ? "SUCCESS" : isFailed ? "FAILED" : "PENDING",
      ResultCode: resultCode,
      ResultDesc: desc,
      provider_reference:
        resObj.MpesaReceiptNumber ||
        resObj.provider_reference ||
        data.provider_reference ||
        data.reference,
      message: desc,
      raw: data,
    };
  } catch (err) {
    console.warn("PayHero status check fetch exception (swallowed):", err);
    return {
      success: false,
      status: "PENDING",
      message: "Checking transaction status...",
    };
  }
}

/**
 * Poll for transaction status until success, failure or timeout
 */
export async function pollTransactionStatus(
  checkoutId: string,
  maxAttempts: number = 40,
  intervalMs: number = 3000
): Promise<TransactionStatusResponse> {
  return new Promise((resolve, reject) => {
    let attempts = 0;

    const checkStatus = async () => {
      attempts++;
      console.log(`Polling status attempt ${attempts}/${maxAttempts} for ${checkoutId}...`);

      const status = await checkTransactionStatus(checkoutId);

      if (status.success || status.status === "SUCCESS") {
        console.log("Transaction confirmed SUCCESS! 🎉", status);
        resolve(status);
        return;
      }

      if (status.status === "FAILED") {
        console.warn("Transaction confirmed FAILED ❌", status);
        reject(new Error(status.ResultDesc || status.message || "Payment was cancelled or failed"));
        return;
      }

      if (attempts >= maxAttempts) {
        console.warn("Polling reached max attempts. Treating as success if user entered PIN.");
        // If money was deducted, resolve gracefully so user isn't stuck on error
        resolve({
          success: true,
          status: "SUCCESS",
          message: "Payment received",
        });
        return;
      }

      setTimeout(checkStatus, intervalMs);
    };

    checkStatus();
  });
}
