import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';
import '../home/home_shell.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      t.translate('app_title'),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const _LanguageSelector(),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                t.translate('sponsored_by'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Card(
                  color: colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.translate('home_banner_title'),
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          t.translate('home_banner_subtitle'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.login),
                          label: Text(t.translate('login')),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.rocket_launch_outlined),
                          label: Text(t.translate('signup')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  final appState = context.read<AppState>();
                  if (!appState.isAuthenticated) {
                    appState.login('guest', 'guest');
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomeShell()),
                  );
                },
                icon: const Icon(Icons.visibility),
                label: const Text('Explore demo mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return DropdownButtonHideUnderline(
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
            appState.setLocale(locale);
          }
        },
      ),
    );
  }
}
