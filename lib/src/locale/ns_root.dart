import 'package:flutter/material.dart';
import 'package:nice_service/src/locale/ns_localization.dart';

import 'ns_locale.dart';

class NSRoot extends StatefulWidget {
  const NSRoot({
    super.key,
    required this.builder,
    this.initialLocale,
    this.locales = const [],
    this.themeMode,
  });

  final Widget Function(
    BuildContext context,
    Locale? locale,
    LocalizationsDelegate<NSLocalizations> delegates,
    ThemeMode? themeMode,
  ) builder;
  final Locale? initialLocale;
  final List<NSLocale> locales;
  final ThemeMode? themeMode;

  static NSRootState? of([BuildContext? context]) {
    return context?.findAncestorStateOfType<NSRootState>();
  }

  @override
  State<NSRoot> createState() => NSRootState();
}

class NSRootState extends State<NSRoot> {
  Locale? locale;
  ThemeMode? themeMode;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    locale = widget.initialLocale;
    themeMode = widget.themeMode;
    super.initState();
  }

  void setLocale(Locale? newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  void setTheme(ThemeMode? v) {
    setState(() {
      themeMode = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      locale,
      NSLocalizationsDelegate(widget.locales),
      themeMode,
    );
  }
}
