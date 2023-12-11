import 'package:bloc_test/bloc_test.dart';
import 'package:events4me/app/modules/home/event/controller/event_controller.dart';
import 'package:events4me/app/modules/home/event/models/event_model.dart';
import 'package:events4me/app/modules/home/event/repositories/event_repository.dart';
import 'package:events4me/app/modules/home/event/states/event_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_utils/app_module.dart';

class EventRepositoryMock extends Mock implements EventRepository {}

void main() {
  late EventController controller;
  late EventRepositoryMock repository;
  late EventsStates state;

  var eventList = [
    EventModel(
      id: 1,
      title: '',
      description: '',
      date: DateTime(2023),
      status: 'Aceito',
    ),
    EventModel(
      id: 1,
      title: '',
      description: '',
      date: DateTime(2023),
      status: 'Recusado',
    ),
  ];

  setUpAll(() {
    setupAppModuleToTests();
  });

  setUp(() {
    state = EventsStates();
    repository = EventRepositoryMock();
    controller = EventController(repository);
  });

  tearDown(() => controller.close());

  group(' Event Controller tests', () {
    blocTest(
      'Should return a list filtered by status',
      build: () => controller,
      seed: () => state.copyWith(eventList: eventList),
      act: (bloc) => bloc.filterEventsByStatus(eventStatus: 'Recusado'),
      expect: () => [
        state.copyWith(
          filterEventList: [
            eventList[1],
          ],
          eventList: eventList,
        )
      ],
    );

    blocTest(
      'Should return eventList filtered by dateTime',
      build: () => controller,
      seed: () => state.copyWith(eventList: eventList),
      act: (bloc) => bloc.filterDates(),
      expect: () => [
        state.copyWith(
            dateList: [DateTime(2023), DateTime(2023)], eventList: eventList)
      ],
    );

    blocTest(
      'Should return a CreateEventSuccess state',
      build: () {
        when(() => repository.createEvent(
            title: '', description: '', date: DateTime(2023))).thenAnswer(
          (_) async => state.copyWith(status: EventStatus.success),
        );

        return controller;
      },
      act: (bloc) => bloc.createEvent(
        title: '',
        description: '',
        date: DateTime(2023),
      ),
      expect: () => [
        state.copyWith(status: EventStatus.loading),
        state.copyWith(status: EventStatus.success),
      ],
    );
    blocTest(
      'Should return a CreateEventError state',
      build: () {
        when(() => repository.createEvent(
            title: '', description: '', date: DateTime(2023))).thenAnswer(
          (_) async => state.copyWith(
              status: EventStatus.error, error: 'Create event error'),
        );

        return controller;
      },
      act: (bloc) => bloc.createEvent(
        title: '',
        description: '',
        date: DateTime(2023),
      ),
      expect: () => [
        state.copyWith(status: EventStatus.loading),
        state.copyWith(
          status: EventStatus.error,
          error: 'Create event error',
        ),
      ],
    );
  });
}
