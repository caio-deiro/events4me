import 'dart:io';

import 'package:events4me/app/modules/auth/register/states/register_states.dart';

abstract class RegisterRepository {
  /// Register a user
  Future<RegisterStates> registerUser({
    required String userName,
    required String password,
    required String email,
    required String phone,
    File? userImage,
  });
}
