import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final appState = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(t.translate('language')),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: appState.locale,
              items: AppLocalizations.supportedLocales
                  .map(
                    (locale) => DropdownMenuItem(
                      value: locale,
                      child: Text(locale.languageCode.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (locale) {
                if (locale != null) {
                  context.read<AppState>().setLocale(locale);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.translate('security_center'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(t.translate('data_security_blurb')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.share),
            title: Text(t.translate('refer_and_earn')),
            subtitle: Text(t.translate('refer_description')),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Referral link copied')),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => context.read<AppState>().logout(),
          icon: const Icon(Icons.logout),
          label: Text(t.translate('logout')),
        ),
      ],
    );
  }
}
