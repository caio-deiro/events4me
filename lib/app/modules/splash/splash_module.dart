import 'package:events4me/app/modules/splash/UI/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => SplashPage());
  }
}
