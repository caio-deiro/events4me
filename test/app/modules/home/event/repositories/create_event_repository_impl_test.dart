import 'package:events4me/app/modules/home/event/repositories/event_repository.dart';
import 'package:events4me/app/modules/home/event/repositories/event_repository_impl.dart';
import 'package:events4me/app/modules/home/event/states/event_state.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../../../test_utils/app_module.dart';

void main() {
  late EventRepository repository;
  late DioService dioService;
  late DioAdapter dioAdapter;
  late EventsStates state;

  setUpAll(() {
    setupAppModuleToTests();
  });

  setUp(() {
    state = EventsStates();
    dioService = DioService();
    dioAdapter = DioAdapter(dio: dioService, matcher: UrlRequestMatcher());
    repository = EventRepositoryImpl(dio: dioService, state: state);
  });
  group('Create event repository tests', () {
    test('When return status 200 should return create event success', () async {
      dioAdapter.onPost('', (server) => server.reply(200, {}));

      final result = await repository.createEvent(
          title: '', description: '', date: DateTime(2023));

      expect(result, state.copyWith(status: EventStatus.success));
    });

    test('When return status 400 should return create event error', () async {
      dioAdapter.onGet('', (server) => server.reply(400, 'Bad request'));

      final result = await repository.createEvent(
          title: '', description: '', date: DateTime(2023));

      expect(
          result,
          state.copyWith(
            status: EventStatus.error,
            error: 'Bad request',
          ));
    });
  });
}
