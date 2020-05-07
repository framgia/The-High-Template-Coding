import 'package:flutter/material.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/locator.dart';

import 'ui/app.dart';

void main() async {
  setupLocator();
  runApp(MyApp());
}
