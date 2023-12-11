import '../states/login_state.dart';

abstract class LoginRepository {
  /// Perform API login
  Future<LoginState> login({required String email, required String password});

  /// Perform Google Login
  Future<LoginState> loginWithGoogle();
}
