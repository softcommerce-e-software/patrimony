class Validator {
  Validator._();

  static String? validatedName(String? name) {
    if (name != null && name.isEmpty) {
      return 'requiredName';
    }

    return null;
  }

  static String? validatedEmail(String? email) {
    final condition = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

    if (email != null && email.isEmpty) {
      return 'requiredEmail';
    }

    if (email != null && !condition.hasMatch(email)) {
      return 'invalidEmail';
    }
    return null;
  }

  static String? validatedPassword(String? password) {
    final condition =
        RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$%\^&\*])(?=.*\d).{8,}$");

    if (password != null && password.isEmpty) {
      return 'requiredPassword';
    }

    if (password != null && !condition.hasMatch(password)) {
      return 'invalidPassword';
    }

    return null;
  }

  static String? validatedConfirmPassword(
      String? password, String? comparePassword) {
    if (password != comparePassword) {
      return 'invalidConfirmPassword';
    }

    return null;
  }
}
