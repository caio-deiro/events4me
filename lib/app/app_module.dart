import 'package:events4me/app/modules/auth/login/login_module.dart';
import 'package:events4me/app/modules/splash/splash_module.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/secure_storage/secure_storage_service.dart';
import 'package:events4me/app/shared/services/user/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<DioService>(DioService.new);
    i.addLazySingleton<GoogleSignIn>(GoogleSignIn.new);
    i.addLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
    i.addLazySingleton<SecureStorageService>(SecureStorageService.new);
    i.addLazySingleton(UserService.new);
  }

  @override
  void routes(r) => [
        r.module('/', module: SplashModule()),
        r.module('/login', module: LoginModule()),
      ];
}
