import 'dart:convert';

import 'package:nice_service/nice_service.dart';

class NSConvert {
  const NSConvert._();
  static String? tStringOrNull(value, {bool allowEmpty = false}) {
    String? targetValue;
    try {
      if (value == null) {
        targetValue = null;
      } else if (value is String) {
        targetValue = value;
      } else if (value is Map || value is List) {
        targetValue = jsonEncode(value);
      } else if (value is int || value is double) {
        return value.toString();
      } else if (value is bool) {
        targetValue = value.toString();
      } else {
        targetValue = value.toString();
      }
    } catch (e) {
      targetValue = null;
    }

    if (!allowEmpty && targetValue != null && targetValue.trim().isEmpty) {
      return null;
    }
    return targetValue;
  }

  static String tString(
    dynamic value, {
    bool allowEmpty = true,
    String defaultValue = "",
  }) {
    return tStringOrNull(value, allowEmpty: allowEmpty) ?? defaultValue;
  }

  static bool tBool(
    dynamic value, {
    /// return true if greater than this number
    num numberThreshold = 0,

    /// return this number if not specified
    bool defaultValue = false,
  }) {
    bool? targetValue;

    if (value is bool) {
      targetValue = value;
    } else if (value is String && value.isNotEmpty) {
      if (value.toLowerCase().replaceAll(" ", "") != "false") {
        targetValue = true;
      }
    } else if ((value is int || value is double)) {
      if (value > numberThreshold) {
        targetValue = true;
      }
    }
    return targetValue ?? defaultValue;
  }

  static int? tIntOrNull(dynamic value) {
    int? targetValue;
    if (value is int) {
      targetValue = value;
    } else if (value is double) {
      targetValue = value.round();
    } else if (value is String && value.isNotEmpty) {
      targetValue = int.tryParse(value);
    }
    return targetValue;
  }

  static int tInt(dynamic value, {int defaultValue = 0}) {
    return tIntOrNull(value) ?? defaultValue;
  }

  static double? tDoubleOrNull(dynamic value) {
    double? targetValue;
    if (value is double) {
      targetValue = value;
    } else if (value is int) {
      targetValue = value.toDouble();
    } else if (value is String) {
      targetValue = double.tryParse(value);
    }
    return targetValue;
  }

  static double tDouble(dynamic value, {double defaultValue = 0.0}) {
    return tDoubleOrNull(value) ?? defaultValue;
  }

  static Map<K, T> tMap<K, T>(val) {
    Map<K, T> v = {};
    if (val is String) {
      try {
        final v2 = jsonDecode(val);
        if (v2 is Map<K, T>) {
          return v2;
        }
      } catch (e) {
        return v;
      }
    }
    return val is Map<K, T> ? val : v;
  }

  static List<T> tList<T>(val) {
    List list = [];
    if (val is List) {
      list = val;
    } else if (val is String) {
      try {
        var decodedJSON = json.decode(val);
        if (decodedJSON is List) {
          list = decodedJSON;
        }
      } catch (e) {}
    }
    if (list is List<T>) {
      return list;
    }
    if (list.isNotEmpty) {
      if (T == String) {
        return list.map((item) => tString(item) as T).toList();
      }
      if (T == int) {
        return list.map((item) => tInt(item) as T).toList();
      }
      if (T == double) {
        return list.map((item) => tDouble(item) as T).toList();
      }
      if (T == bool) {
        return list.map((item) => tBool(item) as T).toList();
      }
      return list.map((item) => item as T).toList();
    }

    return [];
  }

  static List<T>? tListOrNull<T>(
    val, {
    bool allowEmpty = false,
  }) {
    final List<T> list = tList<T>(val);
    if (list.isNotEmpty) {
      return list;
    }

    return null;
  }

  static DateTime? tTime(
    dynamic val, {
    final bool toLocal = true,
  }) {
    DateTime? result;
    if (val is DateTime) {
      result = val;
    } else if (val is int || val is double) {
      if (val < 100000000000) {
        result = DateTime.fromMillisecondsSinceEpoch(val * 1000);
      } else {
        result = DateTime.fromMillisecondsSinceEpoch(val);
      }
    } else if (val is String) {
      result = DateTime.parse(val);
    }

    if (toLocal) {
      return result?.toLocal();
    }
    return result;
  }

  static String tUrl(val) {
    final String str = tString(val);
    if (str.isUrl) {
      return str;
    }
    return "";
  }

  static String? tUrlOrNull(val) {
    final String str = tUrl(val);
    if (str.isNotEmpty) {
      return str;
    }
    return null;
  }

  static dynamic shortenParamForLog(dynamic value, {int keep = 1000}) {
    if (value is String) {
      if (value.length > keep) {
        return value.substring(0, keep - 1);
      }
    }
    return value;
  }

  static String encodeQueryParameters(Map<String, String> params) {
    try {
      return params.entries
          .map((e) =>
              "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}")
          .join("&");
    } catch (e) {
      return "";
    }
  }

  static String? toPrettyJson(dynamic json) {
    try {
      dynamic result = jsonDecode(json);
      return result;
    } catch (e) {
      if (json is Map) {
        return const JsonEncoder.withIndent("  ").convert(json);
      }
      if (json is String) {
        return json;
      }
      if (json != null) {
        return json.toString();
      }
    }

    return null;
  }

  static String toPrice(
    dynamic cents, {
    bool showPlus = false,
    bool isNegative = false,
    String? symbol = "\$",
    int decimalDigits = 2,

    /// 1 if is dollar, 100 if is cent
    double divider = 100,
    bool removeTrailingZeros = false,
    bool thousandSeparator = true,
  }) {
    if (cents != null) {
      dynamic val = cents;
      if (cents is String) {
        val = double.tryParse(cents);
      }
      if (val is num) {
        final bool trueNegative = isNegative || (val < 0);
        String dollarResult = (divider > 1 ? (val / divider) : val)
            .abs()
            .toDouble()
            .toStringAsFixed(decimalDigits);
        List<String> dollarParts = dollarResult.split('.');
        if (thousandSeparator) {
          dollarParts[0] = dollarParts[0].replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          );
        }
        dollarResult = dollarParts.join('.');

        if (removeTrailingZeros && dollarResult != '0') {
          if (dollarResult.endsWith('.00')) {
            dollarResult = dollarResult.substring(0, dollarResult.length - 3);
          } else if (dollarResult.endsWith('0')) {
            dollarResult = dollarResult.substring(0, dollarResult.length - 1);
          }
        }

        if (symbol?.isNotEmpty ?? false) {
          dollarResult = "$symbol$dollarResult";
        }

        if (trueNegative) {
          dollarResult = "-$dollarResult";
        } else if (showPlus) {
          dollarResult = "+$dollarResult";
        }

        return dollarResult;
      }
    }
    return "\$-";
  }

  static String _padZero(int value) {
    return value.toString().padLeft(2, '0');
  }

  static String? tDateString(val) {
    DateTime? d;
    if (val is int || val is double) {
      final int intVal = val is int ? val : val.round();
      if (intVal < 100000000000) {
        d = DateTime.fromMillisecondsSinceEpoch(intVal * 1000);
      } else {
        d = DateTime.fromMillisecondsSinceEpoch(intVal);
      }
    } else if (val is String) {
      d = DateTime.parse(val);
    } else if (val is DateTime) {
      d = val;
    }

    if (d is DateTime) {
      final String year = d.year.toString();
      final String month = _padZero(d.month);
      final String day = _padZero(d.day);
      return '$year-$month-$day';
      // return DateFormat('yyyy-MM-dd').format(d);
    }

    return null;
  }

  static int? tDaysFromNow(val) {
    final DateTime? targetTime = tTime(val);
    if (targetTime is DateTime) {
      final endOfTargetTimeDay = DateTime(targetTime.year, targetTime.month,
          targetTime.day, 23, 59, 59, 999, 999);
      return endOfTargetTimeDay.difference(DateTime.now()).inDays;
    }
    return null;
  }
}

String? tStringOrNull(value, {bool allowEmpty = false}) =>
    NSConvert.tStringOrNull(value, allowEmpty: allowEmpty);

String tString(
  dynamic value, {
  bool allowEmpty = true,
  String defaultValue = "",
}) =>
    NSConvert.tString(
      value,
      allowEmpty: allowEmpty,
      defaultValue: defaultValue,
    );

bool tBool(
  dynamic value, {
  /// return true if greater than this number
  num numberThreshold = 0,

  /// return this number if not specified
  bool defaultValue = false,
}) =>
    NSConvert.tBool(
      value,
      numberThreshold: numberThreshold,
      defaultValue: defaultValue,
    );

int? tIntOrNull(dynamic value) => NSConvert.tIntOrNull(value);
int tInt(dynamic value, {int defaultValue = 0}) =>
    NSConvert.tInt(value, defaultValue: defaultValue);

double? tDoubleOrNull(dynamic value) => NSConvert.tDoubleOrNull(value);

double tDouble(dynamic value, {double defaultValue = 0.0}) =>
    NSConvert.tDouble(value, defaultValue: defaultValue);

Map<K, T> tMap<K, T>(val) => NSConvert.tMap(val);

List<T> tList<T>(val) => NSConvert.tList(val);

List<T>? tListOrNull<T>(
  val, {
  bool allowEmpty = false,
}) =>
    NSConvert.tListOrNull(val, allowEmpty: allowEmpty);

DateTime? tTime(
  dynamic val, {
  final bool toLocal = true,
}) =>
    NSConvert.tTime(val, toLocal: toLocal);

String tUrl(val) => NSConvert.tUrl(val);
String? tUrlOrNull(val) => NSConvert.tUrlOrNull(val);

dynamic shortenParamForLog(dynamic value, {int keep = 1000}) =>
    NSConvert.shortenParamForLog(value);

String encodeQueryParameters(Map<String, String> params) =>
    NSConvert.encodeQueryParameters(params);

String? toPrettyJson(dynamic json) => NSConvert.toPrettyJson(json);

String toPrice(
  dynamic cents, {
  bool showPlus = false,
  bool isNegative = false,
  String? symbol = "\$",
  int decimalDigits = 2,

  /// 1 if is dollar, 100 if is cent
  double divider = 100,
  bool removeTrailingZeros = false,
  bool thousandSeparator = true,
}) =>
    NSConvert.toPrice(
      cents,
      showPlus: showPlus,
      isNegative: isNegative,
      symbol: symbol,
      decimalDigits: decimalDigits,
      divider: divider,
      removeTrailingZeros: removeTrailingZeros,
      thousandSeparator: thousandSeparator,
    );

String? tDateString(val) => NSConvert.tDateString(val);

int? tDaysFromNow(val) => NSConvert.tDaysFromNow(val);
