import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/generated/l10n.dart';
import 'package:{{cookiecutter.flutter_package_name}}/resources/resource.dart';
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

class _RegisterScreenBody extends StatelessWidget {
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
                  registerForm(),
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

  Widget registerForm() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final validatorConfirmPassword = (value) {
          return value == state.registerData["password"];
        };
        final isLoading = state.status is LoadingState;
        final registerCubit = context.read<RegisterCubit>();
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
              onChanged: (email) => registerCubit.inputChange({"email": email}),
            ),
            InputField(
              hint: S.current.password,
              textInputAction: TextInputAction.next,
              validator: Validators.isValidPassword,
              errorText: S.current.password_invalid,
              isPassword: true,
              onChanged: (password) => registerCubit.inputChange({"password": password}),
            ),
            InputField(
              hint: S.current.confirm_password,
              errorText: S.current.confirm_password_invalid,
              validator: validatorConfirmPassword,
              isPassword: true,
              onChanged: (confirmPassword) => registerCubit.inputChange({"confirm_password": confirmPassword}),
            ),
            SizedBox(height: Sizes.size_16),
            CustomButton(
              width: Sizes.size_150,
              enable: state.isAllValid,
              disabledColor: Colors.blueAccent,
              onClick: isLoading ? null : registerCubit.register,
              label: S.current.register.toUpperCase(),
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
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
          },
          child: Text(S.current.have_account),
        ),
      ),
    );
  }
}
