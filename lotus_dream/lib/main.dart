import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'core/utils/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load default locale (can later use shared prefs / device locale)
  final localization = Localization('en');
  await localization.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData(primarySwatch: Colors.purple);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lotus Dream Lucky Draw',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
