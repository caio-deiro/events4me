import 'package:dio/dio.dart';
import 'package:events4me/app/modules/auth/resetPassword/repositories/reset_password_repository.dart';
import 'package:events4me/app/modules/auth/resetPassword/states/reset_password_states.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/dio/error/api_error.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  /// Dio instance
  final DioService dio;

  final ResetPasswordStates state;

  ResetPasswordRepositoryImpl({required this.dio, required this.state});

  /// Perform a reset user password
  @override
  Future<ResetPasswordStates> resetUserPassword({required String email}) async {
    try {
      final data = <String, dynamic>{'email': email};

      await dio.post('', data: FormData.fromMap(data));
      return state.copyWith(status: ResetPasswordStatus.success);
    } on ApiError catch (e) {
      return state.copyWith(
        status: ResetPasswordStatus.error,
        error: e.apiErrorMessage,
      );
    }
  }
}
