part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Map<String, dynamic> loginData;

  final BaseState status;

  LoginState({
    this.loginData = const {},
    this.status = const InitState(),
  });

  @override
  List<Object> get props => [loginData, status.toString()];

  LoginState copyWith({
    Map<String, dynamic> loginData,
    BaseState status,
  }) {
    return LoginState(
      loginData: {...this.loginData, ...?loginData},
      status: status ?? this.status,
    );
  }

  bool get isAllValid =>
      Validators.isValidEmail(loginData["email"]) && Validators.isValidPassword(loginData["password"]);
}
