extension DateTimeExtension on DateTime {
  String get asFormattedString {
    return '$year/$month/$day - $hour:$minute';
  }
}
