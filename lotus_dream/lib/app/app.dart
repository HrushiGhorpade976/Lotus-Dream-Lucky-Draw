import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../screens/auth/auth_gate.dart';
import '../state/app_state.dart';
import 'theme.dart';

class LotusDreamApp extends StatelessWidget {
  const LotusDreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lotus Dream Lucky Draw',
          theme: buildLotusTheme(),
          locale: appState.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const AuthGate(),
        );
      },
    );
  }
}
