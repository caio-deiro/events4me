import 'package:events4me/app/modules/auth/resetPassword/repositories/reset_password_repository_impl.dart';
import 'package:events4me/app/modules/auth/resetPassword/controller/reset_password_controller.dart';
import 'package:events4me/app/modules/auth/resetPassword/UI/reset_password_page.dart';
import 'package:events4me/app/modules/auth/resetPassword/states/reset_password_states.dart';
import 'package:events4me/app/shared/constants/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResetPasswordModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(ResetPasswordStates.new);
    i.addLazySingleton(ResetPasswordRepositoryImpl.new);
    i.addLazySingleton<ResetPasswordController>(ResetPasswordController.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
  }

  @override
  void routes(r) => [
        r.child(AppRoutes.resetPasswordPage,
            child: (context) => ResetPasswordPage()),
      ];
}
