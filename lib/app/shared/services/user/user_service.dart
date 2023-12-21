import 'package:dio/dio.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
  final DioService dio;
  final GoogleSignIn googleSignIn;

  UserService({required this.dio, required this.googleSignIn});

  /// User model instance
  late UserModel user;

  /// Google user instance
  late UserCredential googleUser;

  /// Verify if used is logged
  bool userISlogged = false;

  /// Current Api token
  String? token;

  /// Perform a google account logout
  Future<void> userLogout() async {
    final userIsLoggedWithGoogle = await googleSignIn.isSignedIn();
    if (userIsLoggedWithGoogle) {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      Modular.to.pushReplacementNamed('/login');
    } else {
      Modular.to.pushReplacementNamed('/login');
    }
  }

  Future<String> refreshUserToken() async {
    final data = FormData.fromMap({
      'userId': user.id,
      'token': token,
    });
    final result = await dio.post('', data: data);
    return result.data as String;
  }
}
