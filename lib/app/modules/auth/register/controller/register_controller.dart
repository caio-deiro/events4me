import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:events4me/app/modules/auth/register/repositories/register_repository.dart';
import 'package:events4me/app/modules/auth/register/states/register_states.dart';

class RegisterController extends Cubit<RegisterStates> {
  final RegisterRepository repository;
  RegisterController(this.repository) : super(RegisterStates());

  /// Perform an user register
  Future<void> registerUser({
    required String userName,
    required String password,
    required String email,
    required String phoneNumber,
    File? userImage,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    final resultState = await repository.registerUser(
      userName: userName,
      password: password,
      email: email,
      phone: phoneNumber,
      userImage: userImage,
    );
    emit(resultState);
  }
}
