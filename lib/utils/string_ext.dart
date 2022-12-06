extension StringConverter on String? {
  String? removeChars() {
    String newString = '';
    if (this == null) {
      return '-';
    }
    newString = this ?? '';
    if (newString.length >= 5) {
      return newString.substring(0, newString.length - 5);
    }
    return '-';
  }
}
