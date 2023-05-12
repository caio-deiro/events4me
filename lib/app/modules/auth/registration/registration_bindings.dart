import 'package:events4me/app/modules/auth/registration/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
  }
}
