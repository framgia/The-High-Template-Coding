part of 'register_cubit.dart';

class RegisterState {
  final Map<String, dynamic> registerData;

  final BaseState status;

  RegisterState({
    this.registerData = const {},
    this.status = const InitState(),
  });

  @override
  List<Object> get props => [registerData, status.toString()];

  RegisterState copyWith({
    Map<String, dynamic> registerData,
    BaseState status,
  }) {
    return RegisterState(
      registerData: {...this.registerData, ...?registerData},
      status: status ?? this.status,
    );
  }

  bool get isAllValid =>
      Validators.isValidEmail(registerData["email"]) &&
      Validators.isValidPassword(registerData["password"]) &&
      registerData["password"] == registerData["confirm_password"];
}
