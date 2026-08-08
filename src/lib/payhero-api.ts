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
  status: string; // "Success" | "Failed" | "Pending"
  ResultCode?: string;
  ResultDesc?: string;
  provider_reference?: string;
  message?: string;
}

/**
 * Format phone to 07XXXXXXXX (PayHero expects local format or 254XXXXXXXXX)
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

  console.log("PayHero STK Push →", { ...payload, amount });

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
    throw new Error(data?.message || data?.error || `PayHero error: ${response.status}`);
  }

  // Normalize response — PayHero returns reference as CheckoutRequestID or reference
  const checkoutId =
    data.reference ||
    data.CheckoutRequestID ||
    data.checkout_request_id ||
    data.checkoutRequestId ||
    data.id;

  if (!checkoutId) {
    throw new Error(data?.message || "STK push failed — no checkout ID returned");
  }

  console.log("PayHero STK Push success →", data);

  return {
    success: true,
    CheckoutRequestID: checkoutId,
    reference: checkoutId,
    message: data.message || "STK push sent",
  };
}

/**
 * Check transaction status by reference
 */
export async function checkTransactionStatus(
  reference: string
): Promise<TransactionStatusResponse> {
  const response = await fetch(
    `${API_BASE_URL}/transaction-status?reference=${encodeURIComponent(reference)}`,
    {
      method: "GET",
      headers: { Authorization: AUTH_TOKEN },
    }
  );

  const data = await response.json().catch(() => ({}));

  if (!response.ok) {
    throw new Error(data?.message || `Status check failed: ${response.status}`);
  }

  return data;
}

/**
 * Poll for transaction status until success, failure or timeout
 * Mirrors the franksurvey pattern exactly
 */
export async function pollTransactionStatus(
  checkoutId: string,
  maxAttempts: number = 30,
  intervalMs: number = 3000
): Promise<TransactionStatusResponse> {
  return new Promise((resolve, reject) => {
    let attempts = 0;

    const checkStatus = async () => {
      try {
        attempts++;
        const status = await checkTransactionStatus(checkoutId);

        const raw = String(status.status || "").toLowerCase();
        const isSuccess = raw === "success" || raw === "completed" || raw === "paid";
        const isFailed = raw === "failed" || raw === "cancelled" || raw === "canceled";

        if (isSuccess) {
          resolve({ ...status, success: true });
          return;
        }

        if (isFailed) {
          reject(new Error(status.ResultDesc || status.message || "Payment was cancelled"));
          return;
        }

        if (attempts >= maxAttempts) {
          reject(new Error("Transaction polling timeout — please check status manually"));
          return;
        }

        setTimeout(checkStatus, intervalMs);
      } catch (error) {
        reject(error);
      }
    };

    checkStatus();
  });
}
