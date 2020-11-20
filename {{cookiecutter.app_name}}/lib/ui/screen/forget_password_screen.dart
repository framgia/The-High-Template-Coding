import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/routes.dart';
import 'package:{{cookiecutter.flutter_package_name}}/ui/widget/input_field.dart';
import 'package:{{cookiecutter.flutter_package_name}}/ui/widget/widget.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/screen_utils.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: _ForgetPasswordScreenBody(),
    );
  }
}

class _ForgetPasswordScreenBody extends StatefulWidget {
  @override
  _ForgetPasswordScreenBodyState createState() => _ForgetPasswordScreenBodyState();
}

class _ForgetPasswordScreenBodyState extends State<_ForgetPasswordScreenBody> {
  ForgetPasswordCubit forgetPasswordCubit;

  @override
  void initState() {
    super.initState();
    forgetPasswordCubit = context.read<ForgetPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) async {
          final status = state.status;
          if (status is LoadedState) {
            CustomSnackBar.of(context).show("Please check your email!!");
            await Future.delayed(Duration(seconds: 3));
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
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
                  forgetPasswordForm(),
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

  Widget forgetPasswordForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputField(
          hint: "Email ID",
          validator: Validators.isValidEmail,
          errorText: "Email invalid",
          textInputType: TextInputType.emailAddress,
          onChanged: (email) {
            forgetPasswordCubit.emailChange(email);
          },
        ),
        SizedBox(height: 16),
        BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
          builder: (context, state) {
            final isLoading = state.status is LoadingState;
            return CustomButton(
              width: 150,
              enable: Validators.isValidEmail(state.email),
              disabledColor: Colors.blueAccent,
              onClick: isLoading ? null : forgetPasswordCubit.forgetPassword,
              label: "SUBMIT",
              child: isLoading ? CustomCircleIndicator() : null,
            );
          },
        )
      ],
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
