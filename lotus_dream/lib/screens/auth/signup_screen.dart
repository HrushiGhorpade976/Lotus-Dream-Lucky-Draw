import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cityController = TextEditingController();
  int _entries = 1;
  bool _isHuman = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate() || !_isHuman) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpScreen(
          payload: SignupPayload(
            username: _usernameController.text.trim(),
            mobile: _mobileController.text.trim(),
            password: _passwordController.text,
            city: _cityController.text.trim(),
            entries: _entries,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('signup'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: t.translate('username')),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: t.translate('mobile')),
                validator: (value) => value == null || value.length != 10
                    ? '10-digit mobile'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: t.translate('city')),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: t.translate('password')),
                validator: (value) =>
                    value == null || value.length < 6 ? 'Min 6 chars' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('${t.translate('entries')}: $_entries'),
                  Expanded(
                    child: Slider(
                      min: 1,
                      max: 5,
                      value: _entries.toDouble(),
                      divisions: 4,
                      label: '$_entries',
                      onChanged: (value) =>
                          setState(() => _entries = value.toInt()),
                    ),
                  ),
                ],
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _isHuman,
                onChanged: (value) => setState(() => _isHuman = value ?? false),
                title: Text(t.translate('not_robot')),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isHuman ? _continue : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_forward),
                    const SizedBox(width: 8),
                    Text(t.translate('verify_otp')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupPayload {
  SignupPayload({
    required this.username,
    required this.mobile,
    required this.password,
    required this.city,
    required this.entries,
  });

  final String username;
  final String mobile;
  final String password;
  final String city;
  final int entries;
}
