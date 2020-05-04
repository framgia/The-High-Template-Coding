import 'package:flutter/material.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';

import 'ui/app.dart';

void main() async {
  setupLocator();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}
