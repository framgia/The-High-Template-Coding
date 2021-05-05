import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:{{cookiecutter.flutter_package_name}}/resources/resource.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onClick;
  final double? width;
  final double height;
  final bool enable;
  final Widget? child;
  final Color? enableColor;
  final Color? disabledColor;

  const CustomButton({
    Key? key,
    this.label = "",
    this.onClick,
    this.width,
    this.height = Sizes.size_40,
    this.enable = true,
    this.child,
    this.enableColor,
    this.disabledColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: enable == true
            ? () {
                context.unfocus();
                onClick?.call();
              }
            : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.size_24)),
          onPrimary: enableColor ?? Colors.blue,
          primary: disabledColor,
        ),
        child: child ??
            Text(
              label,
              style: TextStyle(
                fontSize: Sizes.size_16,
                fontWeight: FontWeight.bold,
                color: onClick == null || enable == false ? Colors.white54 : Colors.white,
              ),
            ),
      ),
    );
  }
}
