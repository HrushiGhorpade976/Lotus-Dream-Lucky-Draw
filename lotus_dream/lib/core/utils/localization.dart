import 'dart:convert';
import 'package:flutter/services.dart';

class Localization {
  final String locale;

  Localization(this.locale);

  late Map<String, String> _localizedStrings;

  Future<void> load() async {
    String jsonString = await rootBundle.loadString('lib/l10n/$locale.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String t(String key) => _localizedStrings[key] ?? key;
}
