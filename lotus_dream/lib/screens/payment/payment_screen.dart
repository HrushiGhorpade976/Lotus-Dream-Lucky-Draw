ElevatedButton.icon(
  onPressed = () async {
    final option = appState.paymentOptions[_selectedMethod];

    try {
      final result = await PaymentApi.pay(
        total,
        option.name,
        _entries,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Response: $result")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Error: $e")),
      );
    }
  },
  icon = const Icon(Icons.lock),
  label = Text(t.translate('payment_gateway')),
),
