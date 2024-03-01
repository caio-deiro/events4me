import 'package:dio/dio.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/secure_storage/secure_storage_service.dart';
import 'package:events4me/app/shared/services/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
  /// Google signIn instance
  final GoogleSignIn googleSignIn;

  /// Dioservice instance
  final DioService dioService;

  /// SecureStorage instance
  final SecureStorageService secureStorage;

  /// Class constructor
  UserService({required this.googleSignIn, required this.dioService, required this.secureStorage});

  /// User model instance
  UserModel? user;

  /// Current Api token
  String? token;

  /// Perform a google account logout
  Future<void> userLogout() async {
    final userIsLoggedFromApi = await secureStorage.storageRead(key: 'userIsLogged');
    if (userIsLoggedFromApi == 'true') {
      await secureStorage.storageWrite(key: 'userIsLogged', value: 'false');
      await secureStorage.storageDelete(key: 'token');
      Modular.to.pushReplacementNamed('/login');
    } else {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      Modular.to.pushReplacementNamed('/login');
    }
  }

  Future<Response<dynamic>> callLoginApi() async {
    return await dioService.post('chamar end point do login');
  }

  /// Refresh user token
  Future<String> refreshUserToken() async {
    final data = FormData.fromMap({
      'userId': user?.id,
      'token': token,
    });
    final result = await dioService.post('chamar end point do refresh', data: data);
    return result.data as String;
  }

  // Future<bool> verifyIfUserIsLogged() async {
  //   try {
  //     final secureStorage = Modular.get<SecureStorageService>();
  //     final loginController = Modular.get<LoginController>();

  //     if (await secureStorage.storageRead(key: 'userIsLogged') == 'true') {
  //       var email = await secureStorage.storageRead(key: 'email');
  //       var password = await secureStorage.storageRead(key: 'password');
  //       await loginController.login(email: email!, password: password!);
  //     } else {
  //       FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //         if (user != null) {
  //           Modular.to.navigate(AppModules.eventModule);
  //         } else {
  //           Modular.to.navigate(AppModules.loginModule);
  //         }
  //       });
  //     }
  //   } on ApiError catch (e) {
  //     return false;
  //   }
  // }
}
