part of 'forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  final String? email;
  final BaseState? status;

  ForgetPasswordState({this.email, this.status});

  @override
  List<Object?> get props => [email, status.toString()];

  ForgetPasswordState copyWith({
    String? email,
    BaseState? status,
  }) {
    return ForgetPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }
}
