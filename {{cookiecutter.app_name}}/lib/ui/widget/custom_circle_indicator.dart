import 'package:flutter/material.dart';
import 'package:{{cookiecutter.flutter_package_name}}/resources/resource.dart';

class CustomCircleIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  const CustomCircleIndicator({
    Key? key,
    this.size = Sizes.size_24,
    this.strokeWidth = Sizes.size_2,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
