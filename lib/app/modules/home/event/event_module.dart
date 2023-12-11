import 'package:events4me/app/modules/home/event/controller/event_controller.dart';
import 'package:events4me/app/modules/home/event/repositories/event_repository_impl.dart';
import 'package:events4me/app/modules/home/event/states/event_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EventModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(EventsStates.new);
    i.addLazySingleton(EventRepositoryImpl.new);
    i.addLazySingleton<EventController>(EventController.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
  }

  @override
  void routes(r) => [];
}
