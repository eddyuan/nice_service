import 'package:flutter/material.dart';
import 'package:nice_service/nice_service.dart';

extension NSColorExt on Color {
  Color blendWithOpacity(Color bottomColor) {
    return NSColorUtil.blendWithOpacity(this, bottomColor);
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => NSColorUtil.toHex(this);

  /// Judge if a color is dark
  bool isDark([double threshold = 0.15]) =>
      NSColorUtil.isDark(this, threshold: threshold);

  /// Return a black or white color based on darkness
  Color contrastColor([double threshold = 0.15]) =>
      NSColorUtil.contrastColor(this, threshold: threshold);

  /// Return a black or white color based on darkness but with opacity
  Color contrastColorTrans([double threshold = 0.15]) =>
      NSColorUtil.contrastColorTrans(this, threshold: threshold);

  /// Shade a color
  Color withShade(double factor) => NSColorUtil.shade(this, factor);

  /// Lighten a color
  Color withLighten(double factor) => NSColorUtil.lighten(this, factor);

  /// Tint a color
  Color withTint(double factor) => NSColorUtil.tint(this, factor);

  /// Generate [MaterialColor] from [Color]
  MaterialColor toMaterialColor() => NSColorUtil.materialColor(this);
}
