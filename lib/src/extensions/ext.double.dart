extension NSDoubleExt on double {
  String toStringAsFixedNoZero(int n) =>
      toStringAsFixed(n).replaceFirst(RegExp(r'\.?0*$'), '');
}
