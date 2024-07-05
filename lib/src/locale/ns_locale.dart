import 'package:flutter/material.dart';

class NSLocale {
  NSLocale({
    required this.locale,
    required this.translation,
  });

  final Locale locale;
  final Map<String, String> translation;
}
