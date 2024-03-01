import 'package:events4me/app/modules/home/profile/repositories/profile_repository_impl.dart';
import 'package:events4me/app/modules/home/profile/states/profile_states.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/secure_storage/secure_storage_service.dart';
import 'package:events4me/app/shared/services/user/user_model.dart';
import 'package:events4me/app/shared/services/user/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../../../test_utils/app_module.dart';

void main() {
  late DioService dio;
  late DioAdapter dioAdapter;
  late ProfileRepositoryImpl repository;
  late ProfileStates state;
  late UserService userService;
  late GoogleSignIn googleSignIn;
  late SecureStorageService storageService;

  setUpAll(() {
    Modular.init(BindForTests());
  });

  setUp(() {
    dio = DioService();
    googleSignIn = Modular.get<GoogleSignIn>();
    storageService = Modular.get<SecureStorageService>();
    userService = UserService(googleSignIn: googleSignIn, dioService: dio, secureStorage: storageService);
    dioAdapter = DioAdapter(dio: dio, matcher: UrlRequestMatcher());
    state = ProfileStates();
    repository = ProfileRepositoryImpl(
      dio: dio,
      state: state,
      userService: userService,
    );
  });

  group('Profile repository tests', () {
    test('Should return a user model and return a success state', () async {
      dioAdapter.onPost(
          '',
          (server) => server.reply(
                200,
                {
                  'id': 123,
                  'name': 'caio',
                  'email': 'caio@caio',
                  'phone': '123',
                },
              ));
      userService.token = null;

      userService.user = UserModel(
        id: 1,
        name: 'caio',
        email: 'caio@caio',
        phone: '123456',
      );

      final result = await repository.updateProfile(phone: '123');

      expect(userService.user?.phone, equals('123'));
      expect(
          result,
          state.copyWith(
            status: ProfileStatus.success,
            user: userService.user,
          ));
    });

    test('Should return a Profile error state', () async {
      dioAdapter.onPost('', (server) => server.reply(400, 'Profile Error'));

      userService.user = UserModel(
        id: 1,
        name: 'caio',
        email: 'caio@caio',
        phone: '123456',
      );

      final result = await repository.updateProfile(phone: '123');

      expect(userService.user?.phone, equals('123456'));
      expect(
          result,
          state.copyWith(
            status: ProfileStatus.error,
            user: null,
            error: 'Profile Error',
          ));
    });
  });
}
