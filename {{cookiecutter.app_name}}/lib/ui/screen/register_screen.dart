import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/routes.dart';
import 'package:{{cookiecutter.flutter_package_name}}/ui/widget/widget.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: _RegisterScreenBody(),
    );
  }
}

class _RegisterScreenBody extends StatefulWidget {
  @override
  _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<_RegisterScreenBody> {
  RegisterCubit registerCubit;

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          final status = state.status;
          if (status is LoadedState) {
            final user = status.data;
            context.read<AuthenticationBloc>().add(RegisterEvent(user));
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
                  registerForm(),
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

  Widget registerForm() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final validatorConfirmPassword = (value) {
          return value == state.registerData["password"];
        };
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
              onChanged: (email) => registerCubit.inputChange({"email": email}),
            ),
            InputField(
              hint: "Password",
              textInputAction: TextInputAction.next,
              validator: Validators.isValidPassword,
              errorText: "Password invalid",
              isPassword: true,
              onChanged: (password) => registerCubit.inputChange({"password": password}),
            ),
            InputField(
              hint: "Confirm password",
              errorText: "Confirm password invalid",
              validator: validatorConfirmPassword,
              isPassword: true,
              onChanged: (confirmPassword) => registerCubit.inputChange({"confirm_password": confirmPassword}),
            ),
            SizedBox(height: 16),
            CustomButton(
              width: 150,
              enable: state.isAllValid,
              disabledColor: Colors.blueAccent,
              onClick: isLoading ? null : registerCubit.register,
              label: "REGISTER",
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
      child: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
          },
          child: Text("You have an account? Login"),
        ),
      ),
    );
  }
}
