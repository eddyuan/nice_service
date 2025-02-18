import 'package:flutter/material.dart';
import '../../nice_service.dart';
import 'dart:math' as math;

extension NSNumberExt on num {
  /// rpx is calculated base on 375 width
  double rpx({BuildContext? context, double? max, double? min}) {
    final ctx = context ?? NS.context;
    final vDbl = this.toDouble();
    if (ctx != null) {
      final w = MediaQuery.of(ctx).size.width;
      final tVal = w / 375 * vDbl;
      final mx = max ?? vDbl;
      if (min != null) {
        return tVal.clamp(min, mx);
      } else {
        return math.min(tVal, mx);
      }
    }
    return vDbl;
  }
}
