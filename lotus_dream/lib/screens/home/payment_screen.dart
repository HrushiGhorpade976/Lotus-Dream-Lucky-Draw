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
    final total = _entries * appState.drawConfig.entryFee;

    return Scaffold(
      appBar: AppBar(title: Text(t.translate('payment_gateway'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entry fee: ₹${appState.drawConfig.entryFee.toStringAsFixed(0)}',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('${t.translate('entries')}: $_entries'),
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
              ],
            ),
            Text('Total payable ₹${total.toStringAsFixed(2)}'),
            const SizedBox(height: 24),
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
            ElevatedButton.icon(
              onPressed: () {
                context.read<AppState>().recordPayment(total);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Payment scheduled via ${appState.paymentOptions[_selectedMethod].name}',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.lock),
              label: Text(t.translate('payment_gateway')),
            ),
          ],
        ),
      ),
    );
  }
}
