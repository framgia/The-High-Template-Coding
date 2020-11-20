part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStated extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final User user;

  LoginEvent(this.user);

  @override
  List<Object> get props => [user];
}

class RegisterEvent extends LoginEvent {
  RegisterEvent(User user) : super(user);
}

class LogoutEvent extends AuthenticationEvent {}
