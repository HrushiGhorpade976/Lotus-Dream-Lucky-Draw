import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'state/app_state.dart';
import 'services/api_service.dart';
import 'screens/home/home_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force portrait mode (recommended for lucky draw apps)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Production-ready error screen (no red error UI)
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Text(
          "Something went wrong!",
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  };

  // Backend API service instance
  final api = ApiService(
    baseUrl: "https://your-backend.com/api",
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              AppState(api: api)..loadInitialData(), // preload data
        ),
      ],
      child: const LotusDreamApp(),
    ),
  );
}

class LotusDreamApp extends StatelessWidget {
  const LotusDreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Localization
      locale: app.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],

      // Home
      home: const HomeScreen(),
    );
  }
}
