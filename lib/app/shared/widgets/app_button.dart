import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  const AppButton({Key? key, required this.textButton, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(textButton),
    );
  }
}
