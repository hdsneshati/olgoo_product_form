extension StringExtensions on String {
  String removeLeadingZero() {
    if (this[0] == '0') {
      return substring(1);
    } else {
      return this;
    }
  }
}
