import 'package:events4me/app/shared/utils/tools.dart';
import 'package:flutter/material.dart';

class AppDefaultPage extends StatelessWidget {
  final Widget widget;
  const AppDefaultPage({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Tools.size.width * .15),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Tools.size.height + 1,
          width: Tools.size.width,
          child: widget,
        ),
      ),
    ));
  }
}
