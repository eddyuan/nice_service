import 'package:flutter/material.dart';
import 'package:nice_service/nice_service.dart';

class NSRootConfig {
  final Locale? locale;
  final LocalizationsDelegate<NSLocalizations> delegates;
  final ThemeMode? themeMode;
  final Iterable<Locale> supportedLocales;
  const NSRootConfig({
    this.locale,
    required this.delegates,
    this.themeMode,
    this.supportedLocales = const [],
  });
}

class NSRoot extends StatefulWidget {
  const NSRoot({
    super.key,
    required this.builder,
    this.initialLocale,
    this.locales = const [],
    this.initialThemeMode,
    this.navigatorKey,
  });

  final Widget Function(
    BuildContext context,
    NSRootConfig config,
  ) builder;
  final Locale? initialLocale;
  final Iterable<NSLocale> locales;
  final ThemeMode? initialThemeMode;

  final GlobalKey<NavigatorState>? navigatorKey;

  static NSRootState? of([BuildContext? context]) {
    return context?.findAncestorStateOfType<NSRootState>();
  }

  @override
  State<NSRoot> createState() => NSRootState();
}

class NSRootState extends State<NSRoot> {
  late Locale? locale = widget.initialLocale;
  late ThemeMode? themeMode = widget.initialThemeMode;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    NS.setNavigatorKey(widget.navigatorKey ?? GlobalKey<NavigatorState>());
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
  void didChangeDependencies() {
    if (widget.navigatorKey != null && widget.navigatorKey != NS.navigatorKey) {
      NS.setNavigatorKey(widget.navigatorKey!);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      NSRootConfig(
        locale: locale,
        delegates: NSLocalizationsDelegate(widget.locales),
        themeMode: themeMode,
        supportedLocales: widget.locales.map((x) => x.locale).toList(),
      ),
    );
  }
}
