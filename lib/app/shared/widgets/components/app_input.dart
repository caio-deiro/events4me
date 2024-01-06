import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatefulWidget {
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? iconData;
  final Color? prefixIconColor;
  final String labelText;
  final bool isPasswordInput;

  const AppInput({
    super.key,
    required this.labelText,
    this.width = .99,
    this.inputFormatters,
    this.iconData,
    this.prefixIconColor,
    this.isPasswordInput = false,
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
        inputFormatters: widget.inputFormatters,
        obscureText: widget.isPasswordInput ? obscureText : false,
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
