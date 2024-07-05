extension NSIntExt on int {
  String get toDistance {
    if (this < 0) return "";
    if (this < 1000) return "$this m";
    return "${(this / 1000).toStringAsFixed(1)} km";
  }

  String dhmsFromSeconds([String d = '']) {
    int seconds = this;
    int days = seconds ~/ (24 * 3600);
    seconds %= (24 * 3600);
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;

    String formattedString = '';

    if (days > 0) {
      formattedString += '${days.toString().padLeft(2, '0')}$d ';
    }

    formattedString += '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';

    return formattedString;
  }
}
