import 'package:nice_service/nice_service.dart';

extension NSDateTimeExt on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final yesterday = DateTime.now().add(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool get isThisYear {
    final now = DateTime.now();
    return now.year == year;
  }

  bool get isThisMonth {
    final now = DateTime.now();
    return now.year == year && now.month == month;
  }

  /// This returns the start of today's seconds since epoch
  int get toStartOfDaySeconds => NSDateTimeUtil.toStartOfDaySeconds(this);

  // String displayShort({
  //   String today = "Today",
  //   String yesterday = "Yesterday",
  //   String tomorrow = "Tomorrow",
  // }) {
  //   final locale = NS.locale?.toString();
  //   // String hmFormat = "h:mm a";
  //   String ymd = "";
  //   if (isToday) {
  //     ymd = today;
  //   } else if (isYesterday) {
  //     ymd = yesterday;
  //   } else if (isTomorrow) {
  //     ymd = tomorrow;
  //   } else if (isThisYear) {
  //     ymd = DateFormat.MMMd(locale).format(this);
  //   } else {
  //     ymd = DateFormat.yMMMd(locale).format(this);
  //   }
  //   final hm = DateFormat("HH:mm:ss a").format(this);
  //   return "$ymd $hm";
  // }
}
