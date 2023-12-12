import 'package:events4me/app/modules/home/event/UI/create_event_page.dart';
import 'package:events4me/app/modules/home/event/UI/events_calendar_page.dart';
import 'package:events4me/app/modules/home/event/UI/home_events_page.dart';
import 'package:events4me/app/modules/home/event/controller/event_controller.dart';
import 'package:events4me/app/modules/home/event/repositories/event_repository_impl.dart';
import 'package:events4me/app/modules/home/event/states/event_state.dart';
import 'package:events4me/app/modules/home/profile/profile_module.dart';
import 'package:events4me/app/shared/constants/app_modules.dart';
import 'package:events4me/app/shared/constants/app_routes.dart';
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
  void routes(r) => [
        r.child(AppRoutes.homePage, child: (context) => HomeEventsPage()),
        r.child(AppRoutes.createEventPage,
            child: (context) => CreateEventPage()),
        r.child(AppRoutes.eventsCalendarPage,
            child: (context) => EventsCalendarPage()),
        r.module(AppModules.profileModule, module: ProfileModule())
      ];
}
