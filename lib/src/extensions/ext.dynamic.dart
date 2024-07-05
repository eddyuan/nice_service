// import 'package:nice_service/src/utils/ns_convert.dart';

// extension NSDynamicExt<F> on F? {
//   String? tStringOrNull({
//     bool allowEmpty = false,
//   }) {
//     return NSConvert.tStringOrNull(
//       this,
//       allowEmpty: allowEmpty,
//     );
//   }

//   String tString({
//     bool allowEmpty = true,
//     String defaultValue = "",
//   }) {
//     return NSConvert.tString(
//       this,
//       allowEmpty: allowEmpty,
//       defaultValue: defaultValue,
//     );
//   }

//   bool tBool({
//     /// return true if greater than this number
//     num numberThreshold = 0,

//     /// return this number if not specified
//     bool defaultValue = false,
//   }) {
//     return NSConvert.tBool(
//       this,
//       numberThreshold: numberThreshold,
//       defaultValue: defaultValue,
//     );
//   }

//   int? tIntOrNull() {
//     return NSConvert.tIntOrNull(this);
//   }

//   int tInt({int defaultValue = 0}) {
//     return NSConvert.tInt(
//       this,
//       defaultValue: defaultValue,
//     );
//   }

//   double? tDoubleOrNull() {
//     return NSConvert.tDoubleOrNull(this);
//   }

//   double? tDouble({double defaultValue = 0.0}) {
//     return NSConvert.tDouble(
//       this,
//       defaultValue: defaultValue,
//     );
//   }

//   Map<String, Object> tMap() {
//     return NSConvert.tMap(this);
//   }

//   String toPrice({
//     bool showPlus = false,
//     bool isNegative = false,
//     String? symbol = "\$",
//     int decimalDigits = 2,

//     /// 1 if is dollar, 100 if is cent
//     double divider = 100,
//     bool removeTrailingZeros = false,
//     bool thousandSeparator = true,
//   }) {
//     return NSConvert.toPrice(
//       this,
//       showPlus: showPlus,
//       isNegative: isNegative,
//       symbol: symbol,
//       decimalDigits: decimalDigits,
//       divider: divider,
//       removeTrailingZeros: removeTrailingZeros,
//       thousandSeparator: thousandSeparator,
//     );
//   }

//   String tUrl() {
//     return NSConvert.tUrl(this);
//   }

//   String? tUrlOrNull() {
//     return NSConvert.tUrlOrNull(this);
//   }

//   String? tDateString() {
//     return NSConvert.tDateString(this);
//   }

//   List<T> tList<T>() {
//     return NSConvert.tList<T>(this);
//   }

//   List<T>? tListOrNull<T>({
//     bool allowEmpty = false,
//   }) {
//     return NSConvert.tListOrNull<T>(this);
//   }

//   DateTime? tTime({
//     final bool toLocal = true,
//   }) {
//     return NSConvert.tTime(this);
//   }

//   int? tDaysFromNow() {
//     return NSConvert.tDaysFromNow(this);
//   }
// }
