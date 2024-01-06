import 'package:events4me/app/shared/utils/tools.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final Color? buttonColor;
  final void Function()? onPressed;
  const AppButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.buttonColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Tools.size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
