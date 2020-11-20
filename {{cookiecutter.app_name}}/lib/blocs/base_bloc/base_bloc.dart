import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/base_bloc/base.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(BaseState initialState) : super(InitState());
}
