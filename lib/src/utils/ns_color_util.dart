import 'package:flutter/material.dart';

class NSColorUtil {
  const NSColorUtil._();

  /// Check if the color is dark
  static bool isDark(Color color, {double threshold = 0.15}) {
    final double relativeLuminance = color.computeLuminance();
    return ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) <=
        threshold);
  }

  /// If color is dark, return white, else return black
  static Color contrastColor(Color color, {double threshold = 0.15}) {
    return isDark(color, threshold: threshold)
        ? const Color(0xffffffff)
        : const Color(0xff000000);
  }

  /// Return corresponding contrast color with opacity
  static Color contrastColorTrans(
    Color color, {
    double blackOpacity = 0.12,
    double whiteOpacity = 0.24,
    double threshold = 0.15,
  }) {
    return isDark(color, threshold: threshold)
        ? const Color(0xffffffff).withOpacity(whiteOpacity)
        : const Color(0xff000000).withOpacity(blackOpacity);
  }

  static Color blendWithOpacity(Color topColor, Color bottomColor) {
    final double tAlpha = topColor.opacity;
    if (tAlpha >= 1) {
      return topColor;
    }

    final double tBeta = 1 - tAlpha;
    final int tRed = (tAlpha * topColor.red + tBeta * bottomColor.red).round();
    final int tGreen =
        (tAlpha * topColor.green + tBeta * bottomColor.green).round();
    final int tBlue =
        (tAlpha * topColor.blue + tBeta * bottomColor.blue).round();
    return Color.fromRGBO(tRed, tGreen, tBlue, 1);
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  static String toHex(Color color, {bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';
}
