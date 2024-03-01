import 'package:events4me/app/shared/constants/app_colors.dart';
import 'package:events4me/app/shared/utils/tools.dart';
import 'package:flutter/material.dart';

class AppDefaultPage extends StatelessWidget {
  final bool showLoading;
  final Widget child;
  const AppDefaultPage({super.key, required this.showLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: showLoading,
          child: Container(
            width: Tools.size.width,
            height: Tools.size.height,
            color: AppColors.grey1.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        )
      ],
    );
  }
}
