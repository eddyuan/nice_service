import 'dart:ui';

import 'package:nice_service/nice_service.dart';

extension NSColorExt on Color {
  Color blendWithOpacity(Color bottomColor) {
    return NSColorUtil.blendWithOpacity(this, bottomColor);
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => NSColorUtil.toHex(this);

  bool isDark([double threshold = 0.15]) =>
      NSColorUtil.isDark(this, threshold: threshold);

  Color contrastColor([double threshold = 0.15]) =>
      NSColorUtil.contrastColor(this, threshold: threshold);

  Color contrastColorTrans([double threshold = 0.15]) =>
      NSColorUtil.contrastColorTrans(this, threshold: threshold);
}
