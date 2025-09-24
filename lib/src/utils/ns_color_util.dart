// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class NSColorUtil {
//   const NSColorUtil._();

//   static int _tintValue(int value, double factor) =>
//       math.max(0, math.min((value + ((255 - value) * factor)).round(), 255));

//   static Color tint(Color color, double factor) => Color.fromRGBO(
//       _tintValue(color.red, factor),
//       _tintValue(color.green, factor),
//       _tintValue(color.blue, factor),
//       1);

//   static int _shadeValue(int value, double factor) =>
//       math.max(0, math.min(value - (value * factor).round(), 255));

//   static Color shade(Color color, double factor) => Color.fromRGBO(
//       _shadeValue(color.red, factor),
//       _shadeValue(color.green, factor),
//       _shadeValue(color.blue, factor),
//       1);

//   static int _lightenValue(int value, double factor) =>
//       math.max(0, math.min(value + (value * factor).round(), 255));

//   static Color lighten(Color color, double factor) => Color.fromRGBO(
//       _lightenValue(color.red, factor),
//       _lightenValue(color.green, factor),
//       _lightenValue(color.blue, factor),
//       1);

//   static MaterialColor materialColor(Color color) {
//     return MaterialColor(color.value, {
//       50: tint(color, 1 * 0.95),
//       100: tint(color, 0.8 * 0.95),
//       200: tint(color, 0.6 * 0.95),
//       300: tint(color, 0.4 * 0.95),
//       400: tint(color, 0.2 * 0.95),
//       500: color,
//       600: shade(color, 0.15),
//       700: shade(color, 0.3),
//       800: shade(color, 0.45),
//       900: shade(color, 0.6),
//     });
//   }

//   static Color withOpacity(Color color, double opacity) {
//     return color.withAlpha((255.0 * opacity).round());
//   }

//   /// Check if the color is dark
//   static bool isDark(Color color, {double threshold = 0.15}) {
//     final double relativeLuminance = color.computeLuminance();
//     return ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) <=
//         threshold);
//   }

//   /// If color is dark, return white, else return black
//   static Color contrastColor(Color color, {double threshold = 0.15}) {
//     return isDark(color, threshold: threshold)
//         ? const Color(0xffffffff)
//         : const Color(0xff000000);
//   }

//   /// Return corresponding contrast color with opacity
//   static Color contrastColorTrans(
//     Color color, {
//     double blackOpacity = 0.12,
//     double whiteOpacity = 0.24,
//     double threshold = 0.15,
//   }) {
//     return isDark(color, threshold: threshold)
//         ? const Color(0xffffffff).withOpacity(whiteOpacity)
//         : const Color(0xff000000).withOpacity(blackOpacity);
//   }

//   static Color blendWithOpacity(Color topColor, Color bottomColor) {
//     final double tAlpha = topColor.opacity;
//     if (tAlpha >= 1) {
//       return topColor;
//     }

//     final double tBeta = 1 - tAlpha;
//     final int tRed = (tAlpha * topColor.red + tBeta * bottomColor.red).round();
//     final int tGreen =
//         (tAlpha * topColor.green + tBeta * bottomColor.green).round();
//     final int tBlue =
//         (tAlpha * topColor.blue + tBeta * bottomColor.blue).round();
//     return Color.fromRGBO(tRed, tGreen, tBlue, 1);
//   }

//   /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
//   static String toHex(Color color, {bool leadingHashSign = true}) =>
//       '${leadingHashSign ? '#' : ''}'
//       '${color.alpha.toRadixString(16).padLeft(2, '0')}'
//       '${color.red.toRadixString(16).padLeft(2, '0')}'
//       '${color.green.toRadixString(16).padLeft(2, '0')}'
//       '${color.blue.toRadixString(16).padLeft(2, '0')}';
// }
