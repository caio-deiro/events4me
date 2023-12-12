import 'package:events4me/app/modules/home/profile/UI/profile_page.dart';
import 'package:events4me/app/modules/home/profile/controller/profile_controller.dart';
import 'package:events4me/app/modules/home/profile/repositories/profile_repository_impl.dart';
import 'package:events4me/app/modules/home/profile/states/profile_states.dart';
import 'package:events4me/app/shared/constants/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(ProfileStates.new);
    i.addLazySingleton(ProfileRepositoryImpl.new);
    i.addLazySingleton<ProfileController>(ProfileController.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
  }

  @override
  void routes(r) => [
        r.child(AppRoutes.profilePage, child: (context) => ProfilePage()),
      ];
}
