import 'package:flutter/material.dart';

extension ScreenUtils on BuildContext {
  double getSafeHeight() {
    double height = MediaQuery.of(this).size.height;
    var padding = MediaQuery.of(this).padding;
    return height - padding.top - padding.bottom;
  }

  double getWidth() {
    double width = MediaQuery.of(this).size.width;
    return width;
  }

  double getHeight() {
    double height = MediaQuery.of(this).size.height;
    return height;
  }
}
