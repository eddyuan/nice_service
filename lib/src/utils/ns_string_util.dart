import 'package:flutter/services.dart';

class NSStringUtil {
  const NSStringUtil._();

  //------------ String 函数 --------------
  /// 去掉空格并转为小写作对比
  static bool isSimilar(String a, String b) {
    return a.replaceAll(" ", "").toLowerCase() ==
        b.replaceAll(" ", "").toLowerCase();
  }

  /// convertThisToThis => convert_this_to_this
  static String toSnakeCase(String text, {String separator = '_'}) {
    return _groupIntoWords(text)
        .map((word) => word.toLowerCase())
        .join(separator);
  }

  static final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');
  static final _symbolSet = {' ', '.', '/', '_', '\\', '-'};
  static List<String> _groupIntoWords(String text) {
    var sb = StringBuffer();
    var words = <String>[];
    var isAllCaps = text.toUpperCase() == text;

    for (var i = 0; i < text.length; i++) {
      var char = text[i];
      var nextChar = i + 1 == text.length ? null : text[i + 1];
      if (_symbolSet.contains(char)) {
        continue;
      }
      sb.write(char);
      var isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolSet.contains(nextChar);
      if (isEndOfWord) {
        words.add('$sb');
        sb.clear();
      }
    }
    return words;
  }

  /// 去掉空格并转为小写作对比
  static String toCamelCase(String value) {
    if (value.isEmpty) return "";
    final separatedWords =
        value.split(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%-\s_]+'));
    String newString = '';
    for (final word in separatedWords) {
      newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
    return newString[0].toLowerCase() + newString.substring(1);
  }

  /// 仅首字母大写，其余都小写
  static String toCapitalized(String value) {
    return value.isNotEmpty
        ? '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}'
        : "";
  }

  /// 每个词的首字母大写
  static String toTitleCase(String value) {
    return value.isNotEmpty
        ? value.split(' ').map(toCapitalized).join(' ')
        : "";
  }

  /// 每n个字中间加符号
  static String toSeparated(
    String value,
    int n, {
    bool fromEnd = false,
    String separator = " ",
  }) {
    if (n > 0 && n < value.length && separator.isNotEmpty) {
      if (fromEnd) {
        String reversed = value.split('').reversed.join();
        String result = '';
        for (int i = 0; i < reversed.length; i++) {
          if (i > 0 && i % n == 0) {
            result += separator;
          }
          result += reversed[i];
        }
        return result.split('').reversed.join();
      } else {
        String result = '';
        for (int i = 0; i < value.length; i++) {
          if (i > 0 && i % n == 0) {
            result += separator;
          }
          result += value[i];
        }
        return result;
      }
    }
    return value;
  }

  /// 改成带※的卡号
  static String toObscuredCardNumber(
    String value, {
    String obscureText = "•",
    int targetLength = 16,
    int separatedBy = 4,
    String separator = " ",
    bool substringFromEnd = true,
    bool separateFromEnd = true,
  }) {
    String targetVal = value.replaceAll(" ", "");
    if (targetVal.length < targetLength) {
      targetVal =
          List.generate(targetLength - targetVal.length, (index) => obscureText)
                  .join() +
              targetVal;
    } else if (targetVal.length > targetLength) {
      if (substringFromEnd) {
        targetVal = targetVal.substring(targetVal.length - targetLength);
      } else {
        targetVal = targetVal.substring(0, targetLength);
      }
    }
    return toSeparated(
      targetVal,
      separatedBy,
      fromEnd: separateFromEnd,
      separator: separator,
    );
  }

  /// abcde@123.com => ab*@*3.com
  static String toObscuredEmail(
    String value, {
    String obscureText = "•",
  }) {
    if (value.contains("@")) {
      final parts = value.replaceAll(" ", "").split("@");
      final String first =
          parts.first.length > 3 ? parts.first.substring(0, 3) : parts.first;
      final String last = parts.last.length > 5
          ? parts.last.substring(parts.last.length - 5, parts.last.length)
          : parts.last;
      return '$first$obscureText@$obscureText$last';
    }
    return value;
  }

  /// 获取最后n个字符
  static String takeLast(String value, int n) {
    if (n <= 0) return "";
    if (n >= value.length) return value;
    return value.substring(value.length - n);
  }

  /// 获取起始n个字符
  static String takeFirst(String value, int n) {
    if (n <= 0) return "";
    if (n >= value.length) return value;
    return value.substring(0, n + 1);
  }

  /// 只保留字母和数字
  static toLettersNumbersOnly(String value) {
    return value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), "");
  }

  /// 只保留数字
  static toNumbersOnly(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), "");
  }

  /// 去掉多余的空格，拒绝后端垃圾数据
  static toSingleSpace(String value) {
    return value.replaceAll(RegExp(r"\s+"), " ").trim();
  }

  ///  去掉多余的空格和换行，拒绝后端垃圾数据
  static toSingleSpaceNoBreak(String value) {
    return value.replaceAll("\n", " ").replaceAll(RegExp(r"\s+"), " ").trim();
  }

  /// MMYY 变成 MM/YY
  static String toCardExpiry(
    String value, {
    String separator = "/",
  }) {
    final String numberStr = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numberStr.length == 4) {
      final String month = numberStr.substring(0, 2);
      final String year = numberStr.substring(2);
      return '$month$separator$year';
    }
    return "";
  }

  static Future<void> clipboardCopy(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

  /// 格式校验
  static bool isURL(String s) {
    final urlRegex = RegExp(
        r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$");
    return urlRegex.hasMatch(s);
  }

  /// 格式校验
  static bool isEmail(String s) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(s);
  }
}
