import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nice_service/src/utils/ns_string_util.dart';

extension NSStringExt on String {
  //------------ Compare ------------
  /// 去掉空格并转为小写作对比
  bool isSimilar(String value) {
    return NSStringUtil.isSimilar(this, value);
  }

  //------------ Modifies ------------
  /// convertThisToThis => convert_this_to_this
  String get toSnakeCase => NSStringUtil.toSnakeCase(this);

  /// 转为驼峰写法
  String get toCamelCase => NSStringUtil.toCamelCase(this);

  /// 仅首字母大写，其余都小写
  String get toCapitalized => NSStringUtil.toCapitalized(this);

  /// 每个词的首字母大写
  String get toTitleCase => NSStringUtil.toTitleCase(this);

  /// 每n个字中间加符号
  String toSeparated(
    int n, {
    bool fromEnd = false,
    String separator = " ",
  }) =>
      NSStringUtil.toSeparated(
        this,
        n,
        fromEnd: fromEnd,
        separator: separator,
      );

  /// 改成带※的卡号
  String toObscuredCardNumber({
    String obscureText = "•",
    int targetLength = 16,
    int separatedBy = 4,
    String separator = " ",
    bool substringFromEnd = true,
    bool separateFromEnd = true,
  }) =>
      NSStringUtil.toObscuredCardNumber(
        this,
        obscureText: obscureText,
        targetLength: targetLength,
        separatedBy: separatedBy,
        separator: separator,
        substringFromEnd: substringFromEnd,
        separateFromEnd: separateFromEnd,
      );

  /// abcde@123.com => ab*@*3.com
  String toObscuredEmail({String obscureText = "*"}) =>
      NSStringUtil.toObscuredEmail(this, obscureText: obscureText);

  /// 获取最后n个字符
  String takeLast(int n) => NSStringUtil.takeLast(this, n);

  /// 获取起始n个字符
  String takeFirst(int n) => NSStringUtil.takeFirst(this, n);

  String get toLettersNumbersOnly => NSStringUtil.toLettersNumbersOnly(this);

  /// 变成 MM/YY
  String toCardExpiry() => NSStringUtil.toCardExpiry(this);

  /// 复制到剪切板
  Future<void> clipboardCopy() => NSStringUtil.clipboardCopy(this);

  /// 去掉多余的空格，拒绝后端垃圾数据
  String get toSingleSpace => replaceAll(RegExp(r"\s+"), " ").trim();

  /// 去掉多余的空格和换行，拒绝后端垃圾数据
  String get toSingleSpaceNoBreak {
    return replaceAll("\n", " ").toSingleSpace;
  }

  String or(String val) {
    if (isEmpty) {
      return val;
    }
    return this;
  }

  bool get isUrl => NSStringUtil.isURL(this);
  bool get isEmail => NSStringUtil.isEmail(this);

  double getLayoutHeight(TextStyle style, double width) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: this,
        style: style,
      ),
      maxLines: 100, // Adjust as needed
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: width);
    return textPainter.height;
  }
}
