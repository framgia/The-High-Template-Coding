import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenSate();
  }
}

class _SplashScreenSate extends State<SplashScreen> {
  final int duration = 1;
  Timer? timer;

  void startTime() async {
    timer?.cancel();
    final _duration = Duration(seconds: duration);
    timer = new Timer(_duration, () {
      context.read<AuthenticationBloc>().add(AppStated());
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        final status = state.status;
        switch (status) {
          case AuthenticationStatus.authenticated:
            Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
            break;
          case AuthenticationStatus.unauthenticated:
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
            break;
          default:
        }
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
