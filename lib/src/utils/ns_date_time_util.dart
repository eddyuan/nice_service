class NSDateTimeUtil {
  const NSDateTimeUtil._();

  /// This returns the start of today's seconds since epoch
  static int toStartOfDaySeconds(DateTime date) {
    DateTime start = DateTime(date.year, date.month, date.day);
    return (start.millisecondsSinceEpoch / 1000).round();
  }
}
