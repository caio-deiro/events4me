import 'package:events4me/app/modules/auth/login/repositories/login_repository.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository_impl.dart';
import 'package:events4me/app/modules/auth/login/states/login_state.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/secure_storage/secure_storage_service.dart';
import 'package:events4me/app/shared/services/user/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_utils/app_module.dart';

void main() {
  late LoginRepository loginRepository;
  late DioService dioService;
  late DioAdapter dioAdapter;
  late LoginState state;
  late MockSecureStorageService secureStorageService;
  late UserService userService;

  var token =
      'eyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTcwMDc1ODY5MCwiaWF0IjoxNzAwNzU4NjkwfQ.MjGEvqoNFR4O0p5QE6KmcoyjHxW3-ZtFxrvTIulkE54';

  setUpAll(() {
    setupAppModuleToTests();
  });

  setUp(() {
    state = LoginState();
    dioService = DioService();
    dioAdapter = DioAdapter(dio: dioService, matcher: UrlRequestMatcher());
    secureStorageService = MockSecureStorageService();
    userService = Modular.get<UserService>();
    loginRepository = LoginRepositoryImpl(
      dioService: dioService,
      state: state,
    );
    Modular.replaceInstance<SecureStorageService>(secureStorageService);
  });

  group('login API tests', () {
    test('should get the data and parse to UserModel', () async {
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                'id': 123,
                'name': 'caio',
                'token': token,
                'email': 'caio@caio',
                'phone': '123',
              }));

      when(
        () => secureStorageService.storageWrite(key: 'token', value: token),
      ).thenAnswer(
        (_) async => Future<void>.value,
      );

      when(
        () => secureStorageService.storageRead(key: 'token'),
      ).thenAnswer(
        (_) async => token,
      );

      final result = await loginRepository.login(
        email: 'caio@caio',
        password: '123',
      );
      expect(result, state.copyWith(status: LoginStatus.success));
      expect(userService.token, token);
      expect(userService.user.id, 123);
      expect(userService.user.name, 'caio');
      expect(userService.user.email, 'caio@caio');
      expect(userService.user.phone, '123');
    });

    test('should return a API error', () async {
      userService.token = null;
      dioAdapter.onPost(
        '',
        (server) => server.reply(400, 'login incorreto'),
      );

      final result =
          await loginRepository.login(email: 'caio@caio', password: '123');
      expect(result,
          state.copyWith(status: LoginStatus.error, error: 'login incorreto'));
    });
  });
}
