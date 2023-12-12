import 'package:events4me/app/modules/auth/login/UI/login_page.dart';
import 'package:events4me/app/modules/auth/login/controller/login_controller.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository_impl.dart';
import 'package:events4me/app/modules/auth/login/states/login_state.dart';
import 'package:events4me/app/modules/auth/register/register_module.dart';
import 'package:events4me/app/modules/auth/resetPassword/reset_password_module.dart';
import 'package:events4me/app/shared/constants/app_modules.dart';
import 'package:events4me/app/shared/constants/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton((i) => LoginState.new);
    i.addLazySingleton((i) => LoginRepositoryImpl.new);
    i.addLazySingleton<LoginController>((i) => LoginController.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
  }

  @override
  void routes(r) {
    r.child(AppRoutes.loginPage, child: (context) => LoginPage());
    r.module(AppModules.registerModule, module: RegisterModule());
    r.module(AppModules.resetPasswordModule, module: ResetPasswordModule());
  }
}
