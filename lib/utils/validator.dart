class Validator {
  static bool isUsername(String? username) {
    if (username == null) {
      return false;
    }

    RegExp regExp =
        RegExp('^(?=[a-zA-Z0-9._]{4,20}\$)(?!.*[_.]{2})[^_.].*[^_.]\$');
    return regExp.hasMatch(username);
  }

  static bool isPhoneNumber(String? number) {
    if (number == null) {
      return false;
    }

    RegExp regExp = RegExp(r'(^([+][0-9])[0-9]{10,12}$)');
    return regExp.hasMatch(number);
  }
}
