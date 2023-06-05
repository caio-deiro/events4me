import 'package:events4me/app/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final String status;
  const AppCheckbox({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        border: Border.all(
          color: status == 'accept'
              ? AppColors.green
              : status == 'negative'
                  ? AppColors.red
                  : AppColors.dark,
        ),
      ),
      child: Column(
        children: [
          Visibility(
            visible: status == 'accept',
            child: Icon(
              Icons.check,
              color: AppColors.green,
              size: 10,
            ),
          ),
          Visibility(
            visible: status == 'negative',
            child: Text(
              'x',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.red,
              ),
            ),
          ),
          Visibility(
            visible: status == 'default',
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
