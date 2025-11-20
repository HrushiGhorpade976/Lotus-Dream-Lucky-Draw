import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../home/home_shell.dart';
import 'auth_landing_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    if (appState.isAuthenticated) {
      return const HomeShell();
    }
    return const AuthLandingScreen();
  }
}
