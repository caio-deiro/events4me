import 'package:events4me/app/modules/auth/resetPassword/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResetPasswordPage'),
      ),
      body: Container(),
    );
  }
}
