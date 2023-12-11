import 'package:bloc/bloc.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository.dart';
import 'package:events4me/app/modules/auth/login/states/login_state.dart';

class LoginController extends Cubit<LoginState> {
  final LoginRepository repository;
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
