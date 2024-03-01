import 'package:bloc/bloc.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository.dart';
import 'package:events4me/app/modules/auth/login/states/login_state.dart';
import 'package:flutter/material.dart';

class LoginController extends Cubit<LoginState> {
  /// Login repository
  final LoginRepository repository;

  /// Login formkey
  final formKey = GlobalKey<FormState>();

  /// Class contructor
  LoginController({
    required this.repository,
  }) : super(LoginState());

  /// Perform Api login
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final resultState = await repository.login(
      email: email,
      password: password,
    );
    emit(resultState.copyWith());
  }

  /// Perform google login
  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));
    final resultState = await repository.loginWithGoogle();
    emit(resultState);
  }
}
