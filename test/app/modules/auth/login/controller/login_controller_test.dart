import 'package:bloc_test/bloc_test.dart';
import 'package:events4me/app/modules/auth/login/controller/login_controller.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository.dart';
import 'package:events4me/app/modules/auth/login/repositories/login_repository_impl.dart';
import 'package:events4me/app/modules/auth/login/states/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepositoryImpl {}

class MockGoogleLogin extends Mock implements GoogleSignIn {}

void main() {
  late LoginController controller;
  late LoginRepository repository;
  late LoginState state;

  setUp(() {
    state = LoginState();
    repository = MockLoginRepository();
    controller = LoginController(repository: repository);
  });

  tearDown(() => controller.close());

  group('Test API login cases', () {
    blocTest(
      'should return a LoginSuccess state',
      build: () {
        when((() => repository.login(email: 'teste@teste', password: '123456')))
            .thenAnswer(
                (_) async => state.copyWith(status: LoginStatus.success));
        return controller;
      },
      act: (bloc) => bloc.login(email: 'teste@teste', password: '123456'),
      expect: () => [
        state.copyWith(status: LoginStatus.loading),
        state.copyWith(status: LoginStatus.success),
      ],
    );

    blocTest(
      'should return a LoginError message',
      build: () {
        when((() => repository.login(email: 'teste@teste', password: '123456')))
            .thenAnswer((_) async => state.copyWith(
                status: LoginStatus.error, error: 'Login error'));
        return controller;
      },
      act: (bloc) => bloc.login(email: 'teste@teste', password: '123456'),
      expect: () => [
        state.copyWith(status: LoginStatus.loading),
        state.copyWith(status: LoginStatus.error, error: 'Login error'),
      ],
    );
  });

  group('Test Google login cases', () {
    blocTest(
      'should return a LoginSuccess',
      build: () {
        when(() => repository.loginWithGoogle()).thenAnswer(
          (_) async => state.copyWith(status: LoginStatus.success),
        );
        return controller;
      },
      act: (bloc) => bloc.loginWithGoogle(),
      expect: () => [
        state.copyWith(status: LoginStatus.loading),
        state.copyWith(status: LoginStatus.success)
      ],
    );
    blocTest(
      'should return a LoginError',
      build: () {
        when(() => repository.loginWithGoogle()).thenAnswer(
          (_) async => state.copyWith(
            status: LoginStatus.error,
            error: 'Your email address appears to be malformed.',
          ),
        );
        return controller;
      },
      act: (bloc) => bloc.loginWithGoogle(),
      expect: () => [
        state.copyWith(status: LoginStatus.loading),
        state.copyWith(
          status: LoginStatus.error,
          error: 'Your email address appears to be malformed.',
        )
      ],
    );
  });
}
