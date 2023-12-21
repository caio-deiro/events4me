import 'package:events4me/app/modules/auth/register/UI/register_page.dart';
import 'package:events4me/app/modules/auth/register/controller/register_controller.dart';
import 'package:events4me/app/modules/auth/register/repositories/register_repository_impl.dart';
import 'package:events4me/app/modules/auth/register/states/register_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(RegisterStates.new);
    i.addLazySingleton(RegisterRepositoryImpl.new);
    i.addLazySingleton<RegisterController>(RegisterController.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
  }

  @override
  void routes(r) => [
        r.child('/', child: (context) => RegisterPage()),
      ];
}
