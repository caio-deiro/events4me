import 'package:events4me/app/modules/auth/resetPassword/repositories/reset_password_repository.dart';
import 'package:events4me/app/modules/auth/resetPassword/repositories/reset_password_repository_impl.dart';
import 'package:events4me/app/modules/auth/resetPassword/states/reset_password_states.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../../../test_utils/app_module.dart';

void main() {
  late DioService dio;
  late DioAdapter dioAdapter;
  late ResetPasswordRepository registerRepository;
  late ResetPasswordStates state;

  setUpAll(() {
    setupAppModuleToTests();
  });

  setUp(() {
    state = ResetPasswordStates();
    dio = DioService();
    dioAdapter = DioAdapter(dio: dio, matcher: UrlRequestMatcher());
    registerRepository = ResetPasswordRepositoryImpl(dio: dio, state: state);
  });

  group('Test Reset password API calls', () {
    test('Should return a reset password success state', () async {
      dioAdapter.onPost('', (server) => server.reply(200, {}));

      final result =
          await registerRepository.resetUserPassword(email: 'caio@caio');

      expect(result, state.copyWith(status: ResetPasswordStatus.success));
    });

    test('Should return a reset password error state', () async {
      dioAdapter.onPost(
          '', (server) => server.reply(400, 'reset password error'));

      final result =
          await registerRepository.resetUserPassword(email: 'caio@caio');

      expect(
        result,
        state.copyWith(
          status: ResetPasswordStatus.error,
          error: 'reset password error',
        ),
      );
    });
  });
}
