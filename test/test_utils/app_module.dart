import 'package:events4me/app/app_module.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/secure_storage/secure_storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../app/shared/services/dio/dio_service_test.dart';

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

final mockSecureStorageService = MockSecureStorageService();

final mockFlutterSecureStorage = MockFlutterSecureStorage();

final mockDioService = MockDioService();

final mockGoogleSignIn = MockGoogleSignIn();

void setupAppModuleToTests() {
  Modular.init(AppModule());
  Modular.replaceInstance<FlutterSecureStorage>(mockFlutterSecureStorage);
  Modular.replaceInstance<DioService>(mockDioService);
  Modular.replaceInstance<SecureStorageService>(mockSecureStorageService);
  Modular.replaceInstance<GoogleSignIn>(mockGoogleSignIn);
}
