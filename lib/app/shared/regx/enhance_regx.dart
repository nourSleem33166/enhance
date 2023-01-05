class EnhanceRegExp {
  static RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp name = RegExp(r'^[a-z A-Z,.\-]+$');
  static RegExp phone = RegExp(r'\d');
  static RegExp age = RegExp(
      r'\d',
      caseSensitive: true, multiLine: false);
}