import 'package:events4me/app/modules/auth/resetPassword/states/reset_password_states.dart';

abstract class ResetPasswordRepository {
  /// Perform a reset user password
  Future<ResetPasswordStates> resetUserPassword({required String email});
}
