import 'package:flutter/material.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

class BaseScaffold extends StatelessWidget {
  final bool? canBackPress;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;

  const BaseScaffold({
    Key? key,
    this.canBackPress,
    required this.body,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: WillPopScope(
        onWillPop: () => Future.value(canBackPress ?? true),
        child: GestureDetector(
          onTap: context.unfocus,
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
