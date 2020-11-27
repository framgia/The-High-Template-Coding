import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/network/network.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/repository.dart';
import 'package:{{cookiecutter.flutter_package_name}}/models/user.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthenticationRepository _repository = locator.get<AuthenticationRepository>();

  LoginCubit() : super(LoginState());

  void inputChange(Map<String, dynamic> inputData) {
    emit(state.copyWith(loginData: inputData, status: InputState()));
  }

  Future<void> login() async {
    emit(state.copyWith(status: LoadingState()));
    try {
      final response = await _repository.login(state.loginData);
      if (response is ErrorResponse) {
        emit(state.copyWith(status: ErrorState(data: response.statusMessage)));
      } else {
        final user = User.fromJson(response.data);
        emit(state.copyWith(status: LoadedState(data: user)));
      }
    } catch (e) {
      emit(state.copyWith(status: ErrorState(data: e.toString())));
    }
  }
}
