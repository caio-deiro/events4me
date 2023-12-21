import 'package:dio/dio.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/dio/error/api_error.dart';
import 'package:events4me/app/shared/services/secure_storage/secure_storage_service.dart';
import 'package:events4me/app/shared/services/user/user_model.dart';
import 'package:events4me/app/shared/services/user/user_service.dart';
import 'package:events4me/app/shared/utils/tools.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../states/login_state.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  /// Dioservice instance
  final DioService dioService;

  /// LoginState instance
  final LoginState state;

  LoginRepositoryImpl({
    required this.dioService,
    required this.state,
  });

  var userService = Modular.get<UserService>();

  var appTools = Modular.get<Tools>();

  /// Login with API
  @override
  Future<LoginState> login({String? email, String? password}) async {
    final data = FormData.fromMap({'email': email, 'password': password});
    try {
      final response = await dioService.post('', data: data);
      final secureStorageService = Modular.get<SecureStorageService>();
      await secureStorageService.storageWrite(
        key: 'token',
        value: response.data['token'],
      );
      userService.token = await secureStorageService.storageRead(
        key: 'token',
      );
      final user = UserModel.fromMap(response.data);
      userService.user = user;
      userService.userISlogged = true;
      return state.copyWith(status: LoginStatus.success);
    } on ApiError catch (e) {
      return state.copyWith(
          status: LoginStatus.error, error: e.apiErrorMessage);
    }
  }

  /// Login with google
  @override
  Future<LoginState> loginWithGoogle() async {
    try {
      final googleSignIn = Modular.get<GoogleSignIn>();
      final user = await googleSignIn.signIn();
      final googleAuth = await user?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      userService.googleUser = userCredential;
      return state.copyWith(status: LoginStatus.success);
    } on FirebaseAuthException catch (e) {
      final errorMessage = appTools.getErrorFromFirebaseAuth(e.code);
      return state.copyWith(status: LoginStatus.error, error: errorMessage);
    }
  }
}
