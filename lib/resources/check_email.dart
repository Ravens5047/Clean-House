class EmailValidator {
  static bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    );
    return emailRegExp.hasMatch(email);
  }
}
