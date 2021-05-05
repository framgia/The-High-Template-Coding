import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:{{cookiecutter.flutter_package_name}}/resources/resource.dart';

class InputField extends StatefulWidget {
  final String? hint;
  final double? width;
  final Widget? label;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final String? defaultValue;
  final bool isPassword;
  final double borderRadius;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final String? errorText;
  final Function(String value)? validator;

  const InputField({
    Key? key,
    this.hint,
    this.width,
    this.label,
    this.onChanged,
    this.defaultValue,
    this.isPassword = false,
    this.borderRadius = 20,
    this.textInputType,
    this.inputFormatters,
    this.prefixIcon,
    this.onSubmitted,
    this.textInputAction,
    this.suffix,
    this.maxLength,
    this.errorText,
    this.validator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InputFieldState();
  }
}

class _InputFieldState extends State<InputField> {
  TextEditingController? controller;
  bool isValid = true;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.label != null) ...[
          widget.label!,
          SizedBox(height: Sizes.size_10),
        ],
        Container(
          width: widget.width,
          margin: EdgeInsets.all(Sizes.size_8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: Sizes.size_8)]),
          child: TextFormField(
            maxLines: 1,
            controller: controller,
            onChanged: (value) {
              if (widget.onChanged != null) widget.onChanged!(value);
              if (widget.validator != null){
                setState(() {
                  isValid = widget.validator!(value);
                });
              }

            },
            obscureText: widget.isPassword,
            keyboardType: widget.textInputType,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              focusColor: Colors.white,
              fillColor: Colors.white,
              hintText: widget.hint,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Sizes.size_16,
                vertical: Sizes.size_10,
              ),
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: BoxConstraints(minWidth: Sizes.size_40, maxHeight: Sizes.size_32),
              suffixIcon: widget.suffix,
              suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              counterText: "",
            ),
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onSubmitted,
          ),
        ),
        if (widget.errorText != null && !isValid)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size_24),
            child: Text(
              widget.errorText!,
              style: TextStyle(fontSize: Sizes.size_12, color: Colors.red),
            ),
          )
      ],
    );
  }
}
