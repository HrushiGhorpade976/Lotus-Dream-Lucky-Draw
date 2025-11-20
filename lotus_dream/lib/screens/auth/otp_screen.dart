import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';
import '../home/home_shell.dart';
import 'signup_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.payload});

  final SignupPayload payload;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _otpSent = true;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verify() {
    if (_otpController.text.length != 6) return;
    final appState = context.read<AppState>();
    appState.signup(
      username: widget.payload.username,
      mobile: widget.payload.mobile,
      city: widget.payload.city,
      entries: widget.payload.entries,
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('verify_otp'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${t.translate('otp')} (${widget.payload.mobile})'),
            const SizedBox(height: 12),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(hintText: '123456', counterText: ''),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            Text(
              _otpSent ? 'OTP sent via secure SMS' : 'Resending...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _otpController.text.length == 6 ? _verify : null,
              child: Text(t.translate('verify_otp')),
            ),
            TextButton(
              onPressed: () => setState(() => _otpSent = false),
              child: Text(t.translate('otp')),
            ),
          ],
        ),
      ),
    );
  }
}
