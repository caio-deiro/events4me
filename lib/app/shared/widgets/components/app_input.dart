import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final double? width;
  final String? Function(String?)? validator;
  final IconData? iconData;
  final Color? prefixIconColor;
  final String labelText;
  final bool isPasswordInput;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubimited;

  const AppInput({
    super.key,
    required this.labelText,
    this.width = .99,
    this.validator,
    this.iconData,
    this.prefixIconColor,
    this.isPasswordInput = false,
    this.textInputAction,
    this.onFieldSubimited,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widget.width,
      child: TextFormField(
        validator: widget.validator,
        obscureText: widget.isPasswordInput ? obscureText : false,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubimited,
        decoration: InputDecoration(
          prefixIcon: widget.isPasswordInput
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : Icon(widget.iconData),
          prefixIconColor: widget.prefixIconColor,
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
