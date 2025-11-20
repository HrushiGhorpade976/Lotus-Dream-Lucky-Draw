import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const supportedLocales = [
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      "hello": "Hello",
      "login": "Login",
      "app_title": "Lotus Dream Lucky Draw",
      // Add all EN keys…
    },
    'hi': {
      "hello": "नमस्ते",
      "login": "लॉगिन",
      "app_title": "Lotus Dream भाग्यशाली ड्रा",
      // Add all HI keys…
    },
    'mr': {
      "hello": "नमस्कार",
      "login": "लॉगिन",
      "app_title": "Lotus Dream भाग्यचक्र",
      // Add all MR keys…
    },
  };

  /// Stronger function with fallback + crash-safe behavior
  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Required delegate (your earlier version is correct)
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.any(
        (item) => item.languageCode == locale.languageCode,
      );

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
