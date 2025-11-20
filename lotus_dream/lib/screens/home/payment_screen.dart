import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _entries = 1;
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final appState = context.watch<AppState>();

    // Draw entry fee (configurable from backend)
    final entryFee = appState.drawConfig.entryFee;
    final totalAmount = _entries * entryFee;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('payment_gateway')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ENTRY FEE
            Text(
              '${t.translate("entries")}: $_entries',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            /// ENTRY SLIDER
            Row(
              children: [
                Text(t.translate('entries')),
                Expanded(
                  child: Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    value: _entries.toDouble(),
                    label: '$_entries',
                    onChanged: (value) =>
                        setState(() => _entries = value.toInt()),
                  ),
                ),
                Text('x ₹${entryFee.toStringAsFixed(0)}'),
              ],
            ),

            /// TOTAL
            const SizedBox(height: 12),
            Text(
              'Total: ₹${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            /// PAYMENT METHODS
            Text(
              t.translate('payment_methods'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            ...List.generate(appState.paymentOptions.length, (index) {
              final option = appState.paymentOptions[index];
              final isSelected = _selectedMethod == index;

              return Card(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                child: ListTile(
                  onTap: () => setState(() => _selectedMethod = index),
                  leading: Text(
                    option.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(option.name),
                  subtitle: Text(option.description),
                  trailing: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            }),

            const Spacer(),

            /// PAY NOW BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  appState.recordPayment(totalAmount);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${appState.paymentOptions[_selectedMethod].name} → ₹$totalAmount payment requested',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.lock),
                label: Text(t.translate('cta_pay_now')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
