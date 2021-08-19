import 'package:validators/validators.dart';

class Validators {
  static bool isValidPassword(String? password) {
    return password != null && password.length >= 6;
  }

  static bool isValidEmail(String? email) {
    return email != null && isEmail(email);
  }
}
