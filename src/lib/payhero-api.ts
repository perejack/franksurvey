// PayHero API integration — Channel 11294
// Routes through /api/payhero proxy to avoid CORS

const API_BASE_URL = "/api/payhero";
const CHANNEL_ID = 11294;
const AUTH_TOKEN =
  "Basic V09JN3JiOHpOTnJWSzV1bmw5cjI6WUU0ekxFMkhoTGJwTW40cnJkYTk0SjZ2WVVSdTYxUGFoTTR6ZnhHRQ==";

export interface InitiateSTKPushResponse {
  success: boolean;
  CheckoutRequestID: string;
  reference: string;
  message?: string;
  status?: string;
}

export interface TransactionStatusResponse {
  success: boolean;
  status: "completed" | "failed" | "pending";
  ResultCode?: string | number;
  ResultDesc?: string;
  provider_reference?: string;
  message?: string;
  raw?: any;
}

/**
 * Format phone to local 07XXXXXXXX or 01XXXXXXXX format
 */
function formatPhoneNumber(phone: string): string {
  let cleaned = phone.replace(/\D/g, "");
  if (cleaned.startsWith("0") && cleaned.length === 10) return cleaned;
  if (cleaned.startsWith("254") && cleaned.length === 12) return `0${cleaned.slice(3)}`;
  if ((cleaned.startsWith("7") || cleaned.startsWith("1")) && cleaned.length === 9) return `0${cleaned}`;
  return cleaned;
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
  customReference?: string
): Promise<InitiateSTKPushResponse> {
  const phone = formatPhoneNumber(phoneNumber);

  const externalReference = customReference && !customReference.includes("undefined")
    ? `${customReference}-${Date.now()}`
    : `FS-${Date.now()}-${Math.floor(Math.random() * 100000)}`;

  const payload = {
    amount: Math.round(Number(amount)),
    phone_number: phone,
    channel_id: CHANNEL_ID,
    provider: "m-pesa",
    external_reference: externalReference,
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

  console.log("PayHero STK Push initiated response →", data);

  // PayHero returns reference in data.reference, data.CheckoutRequestID, data.id, or external_reference
  const checkoutId =
    data.reference ||
    data.CheckoutRequestID ||
    data.checkout_request_id ||
    data.checkoutRequestId ||
    data.id ||
    externalReference;

  console.log("STK Push initiated successfully. Tracking Reference ID:", checkoutId);

  return {
    success: true,
    CheckoutRequestID: checkoutId,
    reference: checkoutId,
    message: data.message || "STK push sent! Check your phone and enter PIN.",
  };
}

/**
 * Check payment status using PayHero transaction reference
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

    if (response.status === 404 || data.error_code === "NOT_FOUND") {
      console.warn("Transaction reference not indexed yet by PayHero, treating as pending...");
      return {
        success: false,
        status: "pending",
        message: "Awaiting M-Pesa PIN entry...",
        raw: data,
      };
    }

    const resObj = (data.response || data.data || data) as Record<string, any>;
    const rawStatus = String(
      data.status || data.Status || resObj.status || resObj.Status || data.rawStatus || ""
    ).trim().toUpperCase();

    const resultCode = String(
      data.ResultCode ?? resObj.ResultCode ?? data.result_code ?? resObj.result_code ?? ""
    );

    let mappedStatus: "completed" | "failed" | "pending" = "pending";

    if (
      rawStatus === "SUCCESS" ||
      rawStatus === "COMPLETED" ||
      rawStatus === "PAID" ||
      resultCode === "0"
    ) {
      mappedStatus = "completed";
    } else if (
      rawStatus === "FAILED" ||
      rawStatus === "CANCELLED" ||
      rawStatus === "CANCELED"
    ) {
      mappedStatus = "failed";
    } else {
      mappedStatus = "pending";
    }

    const desc =
      resObj.ResultDesc ||
      data.ResultDesc ||
      data.message ||
      resObj.message ||
      (mappedStatus === "completed" ? "Payment confirmed" : "Awaiting PIN entry");

    return {
      success: mappedStatus === "completed",
      status: mappedStatus,
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
    console.warn("PayHero status check network exception (retrying...):", err);
    return {
      success: false,
      status: "pending",
      message: "Awaiting M-Pesa PIN entry...",
    };
  }
}

/**
 * Poll payment status:
 * - Resolves completed ONLY when PayHero explicitly returns SUCCESS/COMPLETED/PAID.
 * - Rejects on explicit failure or timeout.
 * - Retries on pending/404/network errors.
 */
export async function pollTransactionStatus(
  checkoutId: string,
  maxAttempts: number = 25,
  intervalMs: number = 3500
): Promise<TransactionStatusResponse> {
  return new Promise((resolve, reject) => {
    let attempts = 0;

    const checkStatus = async () => {
      if (attempts >= maxAttempts) {
        console.warn("Payment status polling timed out.");
        reject(new Error("Payment confirmation timed out. Please check your phone and try again."));
        return;
      }
      attempts++;

      console.log(`Polling payment status attempt ${attempts}/${maxAttempts} for ref [${checkoutId}]...`);

      try {
        const res = await checkTransactionStatus(checkoutId);

        if (res.status === "completed" || res.success) {
          console.log("Payment status CONFIRMED COMPLETED! 🎉", res);
          resolve(res);
          return;
        }

        if (res.status === "failed") {
          console.warn("Payment status CONFIRMED FAILED ❌", res);
          reject(new Error(res.ResultDesc || res.message || "Payment failed or was cancelled"));
          return;
        }

        // Still pending (user hasn't entered PIN yet) — poll again
        setTimeout(checkStatus, intervalMs);
      } catch (error) {
        // Network glitch during check — poll again
        console.warn("Polling attempt encountered error, retrying...", error);
        setTimeout(checkStatus, intervalMs);
      }
    };

    // Initial 3s delay before first status check
    setTimeout(checkStatus, 3000);
  });
}
