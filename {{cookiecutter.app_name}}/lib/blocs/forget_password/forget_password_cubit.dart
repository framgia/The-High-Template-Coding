import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/base_bloc/base.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/network/network.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/repository.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  AuthenticationRepository _repository = locator.get<AuthenticationRepository>();

  ForgetPasswordCubit() : super(ForgetPasswordState());

  void emailChange(String email) {
    emit(state.copyWith(email: email, status: InputState()));
  }

  Future<void> forgetPassword() async {
    emit(state.copyWith(status: LoadingState()));
    try {
      final response = await _repository.forgetPassword(state.email);
      if (response is ErrorResponse) {
        emit(state.copyWith(status: ErrorState(data: response.statusMessage)));
      } else {
        emit(state.copyWith(status: LoadedState(data: true)));
      }
    } catch (e) {
      emit(state.copyWith(status: ErrorState(data: e.toString())));
    }
  }
}
