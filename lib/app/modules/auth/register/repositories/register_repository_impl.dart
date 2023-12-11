import 'dart:io';

import 'package:dio/dio.dart';
import 'package:events4me/app/modules/auth/register/repositories/register_repository.dart';
import 'package:events4me/app/modules/auth/register/states/register_states.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/dio/error/api_error.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  /// DioService instance
  final DioService dio;

  /// LoginState instance
  final RegisterStates state;

  RegisterRepositoryImpl({required this.dio, required this.state});

  /// Register a user
  @override
  Future<RegisterStates> registerUser({
    required String userName,
    required String password,
    required String email,
    required String phone,
    File? userImage,
  }) async {
    var data = <String, dynamic>{
      'username': userName,
      'password': password,
      'email': email,
      'phone': phone,
    };

    if (userImage != null && userImage.existsSync()) {
      data['image'] = await MultipartFile.fromFile(userImage.path);
    }

    try {
      await dio.post('', data: FormData.fromMap(data));
      return state.copyWith(status: RegisterStatus.success);
    } on ApiError catch (e) {
      return state.copyWith(
          status: RegisterStatus.error, error: e.apiErrorMessage);
    }
  }
}
