import 'package:flutter/material.dart';

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar.of(this.context);

  void show(String message) {
    try {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.lightBlue),
      );
    } catch (e) {
      print('Error - showSnackBar: $e');
    }
  }
}
