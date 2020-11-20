import 'package:flutter/material.dart';
import 'package:{{cookiecutter.flutter_package_name}}/ui/screen/screens.dart';

class Routes {
  Routes._();

  //screen name
  //example
  static const String homeScreen = "/homeScreen";
  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
  static const String registerScreen = "/registerScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";

  //init screen name
  static String get initScreen => splashScreen;

  static final routes = <String, WidgetBuilder>{
    homeScreen: (context) => HomeScreen(),
    splashScreen: (context) => SplashScreen(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    forgetPasswordScreen: (context) => ForgetPasswordScreen(),
  };
}
