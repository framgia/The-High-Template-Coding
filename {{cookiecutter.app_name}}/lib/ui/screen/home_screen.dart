import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/home_repository.dart';
import 'package:{{cookiecutter.flutter_package_name}}/localizations.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/locator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(homeRepository: locator<HomeRepository>())..add(GetData()),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<HomeBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadingState) return CircularProgressIndicator();
              if (state is LoadedState) return Text(state.data);
              return Text(Language.of(context).getText("example"));
            },
          ),
        ),
      ),
    );
  }
}
