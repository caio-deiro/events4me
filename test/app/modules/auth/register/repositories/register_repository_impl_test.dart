import 'package:events4me/app/modules/auth/register/repositories/register_repository.dart';
import 'package:events4me/app/modules/auth/register/repositories/register_repository_impl.dart';
import 'package:events4me/app/modules/auth/register/states/register_states.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../../../test_utils/app_module.dart';

void main() {
  late DioService dio;
  late DioAdapter dioAdapter;
  late RegisterRepository registerRepository;
  late RegisterStates state;

  setUpAll(() {
    setupAppModuleToTests();
  });

  setUp(() {
    state = RegisterStates();
    dio = DioService();
    dioAdapter = DioAdapter(dio: dio, matcher: UrlRequestMatcher());
    registerRepository = RegisterRepositoryImpl(dio: dio, state: state);
  });

  group('Test Register API calls', () {
    test('Should return a Sucess state', () async {
      dioAdapter.onPost(
          '',
          (server) => server.reply(
                200,
                {
                  'username': 'caio',
                  'email': 'caio@caio.com',
                  'phone': '123',
                },
              ));

      final result = await registerRepository.registerUser(
        userName: 'caio',
        password: 'caio',
        email: 'caio@caio',
        phone: '123',
      );

      expect(result, state.copyWith(status: RegisterStatus.success));
    });
    test('Should return a Error state', () async {
      dioAdapter.onPost(
          '',
          (server) => server.reply(
                400,
                'Register error',
              ));

      final result = await registerRepository.registerUser(
        userName: 'caio',
        password: 'caio',
        email: 'caio@caio',
        phone: '123',
      );

      expect(
          result,
          state.copyWith(
            status: RegisterStatus.error,
            error: 'Register error',
          ));
    });
  });
}
