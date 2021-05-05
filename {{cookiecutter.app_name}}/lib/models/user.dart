import 'package:equatable/equatable.dart';
import 'package:sample/utils/utils.dart';

class User extends Equatable {
  final String? email;
  final String? password;

  User({this.email, this.password});

  @override
  List<Object?> get props => [email, password];

  @override
  String toString() {
    return "User : {email: $email, password: $password}";
  }

  User copy({
    String? email,
    String? password,
  }) {
    return User(email: email ?? this.email, password: password ?? this.password);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      password: json["password"],
    );
  }

  get isValidEmail => Validators.isValidEmail(email);

  get isValidPassword => Validators.isValidPassword(password);
}
