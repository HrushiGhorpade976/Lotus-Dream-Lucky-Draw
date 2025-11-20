class PaymentService {
  /// Placeholder for GPay / PhonePe integration
  Future<bool> pay(double amount, String userId) async {
    // TODO: Implement GPay / PhonePe SDK integration
    await Future.delayed(const Duration(seconds: 2));
    return true; // Payment success
  }
}
