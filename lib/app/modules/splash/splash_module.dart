import 'package:events4me/app/app_module.dart';
import 'package:events4me/app/modules/splash/UI/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [AppModule()];
  @override
  void routes(r) {
    r.child('/', child: (context) => SplashPage());
  }
}
