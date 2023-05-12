import 'package:events4me/app/modules/auth/resetPassword/reset_password_controller.dart';
import 'package:get/get.dart';

class ResetPasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}
