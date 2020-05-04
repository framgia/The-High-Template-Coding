import 'package:flutter/material.dart';
import 'package:flutter_template/localizations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Language.of(context).getText("example")),
      ),
    );
  }
}
