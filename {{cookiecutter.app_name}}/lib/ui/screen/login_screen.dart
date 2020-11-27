import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
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

class _LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.all(8),
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
                        size: 100,
                      ),
                    ),
                  ),
                  loginForm(),
                  Spacer(),
                  footerView(),
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
              hint: "Email",
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
              validator: Validators.isValidEmail,
              errorText: "Email invalid",
              onChanged: (email) {
                loginCubit.inputChange({"email": email});
              },
            ),
            InputField(
              hint: "Password",
              validator: Validators.isValidPassword,
              isPassword: true,
              errorText: "Password invalid",
              onChanged: (password) {
                loginCubit.inputChange({"password": password});
              },
            ),
            SizedBox(height: 16),
            CustomButton(
              width: 150,
              enable: state.isAllValid,
              disabledColor: Colors.blueAccent,
              onClick: isLoading ? null : loginCubit.login,
              label: "LOGIN",
              child: isLoading ? CustomCircleIndicator() : null,
            )
          ],
        );
      },
    );
  }

  Widget footerView() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.registerScreen);
                },
                child: Text("Register"),
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: 1,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.forgetPasswordScreen);
                },
                child: Text("Forget password?"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
