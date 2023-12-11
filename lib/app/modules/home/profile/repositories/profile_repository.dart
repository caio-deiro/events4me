import 'dart:io';

import 'package:events4me/app/modules/home/profile/states/profile_states.dart';

abstract class ProfileRepository {
  Future<ProfileStates> updateProfile({
    String? phone,
    String? name,
    File? userImage,
  });
}
