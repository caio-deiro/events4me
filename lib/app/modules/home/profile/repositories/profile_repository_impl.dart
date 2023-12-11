import 'dart:io';

import 'package:dio/dio.dart';
import 'package:events4me/app/modules/home/profile/repositories/profile_repository.dart';
import 'package:events4me/app/modules/home/profile/states/profile_states.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/dio/error/api_error.dart';
import 'package:events4me/app/shared/services/user/user_model.dart';
import 'package:events4me/app/shared/services/user/user_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final DioService dio;
  final ProfileStates state;
  final UserService userService;

  ProfileRepositoryImpl({
    required this.dio,
    required this.state,
    required this.userService,
  });

  @override
  Future<ProfileStates> updateProfile({
    String? phone,
    String? name,
    File? userImage,
  }) async {
    try {
      var data = <String, dynamic>{
        'id': userService.user.id,
      };

      if (phone != null) {
        data['phone'] = phone;
      }

      if (name != null) {
        data['name'] = name;
      }

      if (userImage != null && userImage.existsSync()) {
        data['image'] = MultipartFile.fromFile(userImage.path);
      }

      final result = await dio.post('', data: FormData.fromMap(data));
      final user = UserModel.fromMap(result.data);
      userService.user = user;
      return state.copyWith(status: ProfileStatus.success, user: user);
    } on ApiError catch (e) {
      return state.copyWith(
          status: ProfileStatus.error, error: e.apiErrorMessage);
    }
  }
}
