import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/generated/l10n.dart';
import 'package:{{cookiecutter.flutter_package_name}}/resources/resource.dart';
import 'package:{{cookiecutter.flutter_package_name}}/routes.dart';
import 'package:{{cookiecutter.flutter_package_name}}/ui/widget/widget.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          final status = state.status;
          if (status is LoadedState) {
            final user = status.data;
            context.read<AuthenticationBloc>().add(LoginEvent(user));
          } else if (status is ErrorState) {
            CustomSnackBar.of(context).show(status.data.toString());
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(Sizes.size_8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: context.getSafeHeight()),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: FlutterLogo(
                        size: Sizes.size_100,
                      ),
                    ),
                  ),
                  loginForm(),
                  Spacer(),
                  footerView(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state.status is LoadingState;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputField(
              hint: S.current.email,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
              validator: Validators.isValidEmail,
              errorText: S.current.email_invalid,
              onChanged: (email) {
                context.read<LoginCubit>().inputChange({"email": email});
              },
            ),
            InputField(
              hint: S.current.password,
              validator: Validators.isValidPassword,
              isPassword: true,
              errorText: S.current.password_invalid,
              onChanged: (password) {
                context.read<LoginCubit>().inputChange({"password": password});
              },
            ),
            SizedBox(height: Sizes.size_16),
            CustomButton(
              width: Sizes.size_150,
              enable: state.isAllValid,
              disabledColor: Colors.blueAccent,
              onClick: isLoading ? null : context.read<LoginCubit>().login,
              label: S.current.login.toUpperCase(),
              child: isLoading ? CustomCircleIndicator() : null,
            )
          ],
        );
      },
    );
  }

  Widget footerView(BuildContext context) {
    return SizedBox(
      height: Sizes.size_40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.registerScreen);
            },
            child: Text(S.current.login),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: Sizes.size_1,
            thickness: Sizes.size_1,
            indent: Sizes.size_10,
            endIndent: Sizes.size_10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.forgetPasswordScreen);
            },
            child: Text(S.current.forget_password),
          )
        ],
      ),
    );
  }
}
