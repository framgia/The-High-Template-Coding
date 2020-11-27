import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/repository.dart';
import 'package:{{cookiecutter.flutter_package_name}}/models/user.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository _repository = locator.get<AuthenticationRepository>();

  AuthenticationBloc() : super(AuthenticationState.unknown());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is LoginEvent) {
      await _repository.saveUser(event.user);
      yield AuthenticationState.authenticated(event.user);
    }
    if (event is LogoutEvent) {
      await _repository.clearUser();
      yield AuthenticationState.unauthenticated();
    }
    if (event is AppStated) {
      final user = await _repository.getUser();
      if (user != null) {
        yield AuthenticationState.authenticated(user);
      } else {
        yield AuthenticationState.unauthenticated();
      }
    }
  }
}
