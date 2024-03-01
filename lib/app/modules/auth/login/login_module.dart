import 'package:events4me/app/app_module.dart';
import 'package:events4me/app/modules/auth/login/UI/login_page.dart';
import 'package:events4me/app/modules/auth/login/controller/login_controller.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository_impl.dart';
import 'package:events4me/app/modules/auth/login/states/login_state.dart';
import 'package:events4me/app/modules/auth/register/register_module.dart';
import 'package:events4me/app/modules/auth/resetPassword/reset_password_module.dart';
import 'package:events4me/app/shared/constants/app_modules.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(i) {
    i.addLazySingleton<LoginState>(LoginState.new);
    i.add<LoginRepository>(LoginRepositoryImpl.new);
    i.add<LoginController>(LoginController.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => LoginPage(
              controller: Modular.get<LoginController>(),
            ));
    r.module(AppModules.registerModule, module: RegisterModule());
    r.module(AppModules.resetPasswordModule, module: ResetPasswordModule());
  }
}
