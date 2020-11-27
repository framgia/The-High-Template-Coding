import 'package:flutter/material.dart';

class CustomCircleIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  const CustomCircleIndicator({
    Key key,
    this.size = 24,
    this.strokeWidth = 2,
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
