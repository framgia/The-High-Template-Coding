import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/generated/l10n.dart';
import 'package:{{cookiecutter.flutter_package_name}}/resources/resource.dart';
import 'package:{{cookiecutter.flutter_package_name}}/routes.dart';
import 'package:{{cookiecutter.flutter_package_name}}/ui/widget/widget.dart';
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

class _ForgetPasswordScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) async {
          final status = state.status;
          if (status is LoadedState) {
            await CustomSnackBar.of(context).show(S.current.check_mail);
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
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
                  forgetPasswordForm(context),
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

  Widget forgetPasswordForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputField(
          hint: S.current.email,
          validator: Validators.isValidEmail,
          errorText: S.current.email_invalid,
          textInputType: TextInputType.emailAddress,
          onChanged: (email) {
            context.read<ForgetPasswordCubit>().emailChange(email);
          },
        ),
        SizedBox(height: Sizes.size_16),
        BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
          builder: (context, state) {
            final isLoading = state.status is LoadingState;
            return CustomButton(
              width: Sizes.size_150,
              enable: Validators.isValidEmail(state.email),
              disabledColor: Colors.blueAccent,
              onClick: isLoading ? null : context.read<ForgetPasswordCubit>().forgetPassword,
              label: S.current.submit.toUpperCase(),
              child: isLoading ? CustomCircleIndicator() : null,
            );
          },
        )
      ],
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
