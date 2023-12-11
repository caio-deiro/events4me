import 'package:bloc/bloc.dart';
import 'package:events4me/app/modules/auth/resetPassword/repositories/reset_password_repository.dart';
import 'package:events4me/app/modules/auth/resetPassword/states/reset_password_states.dart';

class ResetPasswordController extends Cubit<ResetPasswordStates> {
  final ResetPasswordRepository repository;
  ResetPasswordController(this.repository) : super(ResetPasswordStates());

  /// Perform a reset user password
  Future<void> resetUserPassword({required String email}) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));
    final resultState = await repository.resetUserPassword(email: email);
    emit(resultState);
  }
}
