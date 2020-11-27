import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String label;
  final Function() onClick;
  final double width;
  final double height;
  final bool enable;
  final Widget child;
  final Color enableColor;
  final Color disabledColor;

  const CustomButton({
    Key key,
    this.label = "",
    this.onClick,
    this.width,
    this.height = 40,
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
      child: RaisedButton(
        onPressed: enable == true ? onClick : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: enableColor ?? Colors.blueAccent,
        disabledColor: disabledColor ,
        child: child ??
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: onClick == null || enable == false ? Colors.white54 : Colors.white,
              ),
            ),
      ),
    );
  }
}
