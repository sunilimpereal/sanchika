import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DemoLocalization {
  final Locale locale;
  DemoLocalization(this.locale);
  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String> _localizedValues;
  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString("lib/lang/${locale.languageCode}.json");

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String gettranslatedvalue(String key) {
    return _localizedValues[key];
  }

  // static
  static const LocalizationsDelegate<DemoLocalization> delegate =
      _DemoLoalizationDelegate();
}

class _DemoLoalizationDelegate extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLoalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ml'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalization> old) =>
      false;
}
