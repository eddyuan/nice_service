import 'package:flutter/material.dart';
import 'package:nice_service/src/locale/ns_locale.dart';

class NSLocalizations {
  final Locale locale;
  final Map<String, String> translations;

  NSLocalizations(this.locale, this.translations);

  static NSLocalizations of(BuildContext? context) {
    if (context != null) {
      return Localizations.of<NSLocalizations>(context, NSLocalizations) ??
          NSLocalizations(const Locale('en'), {});
    }
    return NSLocalizations(const Locale('en'), {});
  }

  static LocalizationsDelegate<NSLocalizations> delegate(
      List<NSLocale> locales) {
    return NSLocalizationsDelegate(locales);
  }

  String translate(
    String key, {
    Map<String, String>? params,
    String? pluralKey,
    num? plural,
  }) {
    if ((pluralKey != null && pluralKey.isNotEmpty) && (plural != 1)) {
      String translated = translations[pluralKey] ?? pluralKey;
      if (params != null) {
        params.forEach((k, v) {
          translated = translated.replaceAll("@$k", v);
        });
      }
      return translated;
    } else {
      String translated = translations[key] ?? key;
      if (params != null) {
        params.forEach((k, v) {
          translated = translated.replaceAll("@$k", v);
        });
      }
      return translated;
    }
  }
}

class NSLocalizationsDelegate extends LocalizationsDelegate<NSLocalizations> {
  final Iterable<NSLocale> locales;

  const NSLocalizationsDelegate(this.locales);

  @override
  bool isSupported(Locale locale) {
    return locales
        .any((nsLocale) => nsLocale.locale.languageCode == locale.languageCode);
  }

  @override
  Future<NSLocalizations> load(Locale locale) async {
    NSLocale? nsLocale;
    for (var l in locales) {
      if (locale == l.locale) {
        nsLocale = l;
        break;
      }
    }
    if (nsLocale == null) {
      for (var l in locales) {
        if (locale.languageCode == l.locale.languageCode &&
            locale.scriptCode == l.locale.scriptCode) {
          nsLocale = l;
          break;
        }
      }
    }
    if (nsLocale == null) {
      for (var l in locales) {
        if (locale.languageCode == l.locale.languageCode) {
          nsLocale = l;
          break;
        }
      }
    }
    return NSLocalizations(locale, nsLocale?.translation ?? {});
  }

  @override
  bool shouldReload(NSLocalizationsDelegate old) => false;
}
