/**
 * Implement provider-specific logic here (Razorpay, PhonePe, GPay server-side verification)
 * This is a placeholder that simulates "successful payment"
 */
export const processPayment = async ({ userId, amount }) => {
  // TODO: integrate with payment gateway SDK
  return { success: true, txId: `tx_${Date.now()}` };
};
