import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/repository.dart';
import 'package:{{cookiecutter.flutter_package_name}}/generated/l10n.dart';
import 'package:{{cookiecutter.flutter_package_name}}/ui/widget/widget.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(homeRepository: locator<HomeRepository>())..add(GetData()),
      child: BaseScaffold(
        body: Center(
          child: BlocBuilder<HomeBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadingState)
                return CustomCircleIndicator(
                  color: Colors.lightBlue,
                );
              if (state is LoadedState)
                return CustomButton(
                  label: S.current.login.toUpperCase(),
                  onClick: () {
                    context.read<AuthenticationBloc>().add(LogoutEvent());
                  },
                );
              return Wrap();
            },
          ),
        ),
      ),
    );
  }
}
