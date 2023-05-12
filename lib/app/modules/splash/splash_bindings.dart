import 'package:events4me/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
