import 'package:bloc_test/bloc_test.dart';
import 'package:events4me/app/modules/auth/resetPassword/controller/reset_password_controller.dart';
import 'package:events4me/app/modules/auth/resetPassword/repositories/reset_password_repository.dart';
import 'package:events4me/app/modules/auth/resetPassword/states/reset_password_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockResetPasswordRepository extends Mock
    implements ResetPasswordRepository {}

void main() {
  late ResetPasswordController resetPasswordController;
  late MockResetPasswordRepository mockResetPasswordRepository;
  late ResetPasswordStates state;

  setUp(() {
    state = ResetPasswordStates();
    mockResetPasswordRepository = MockResetPasswordRepository();
    resetPasswordController =
        ResetPasswordController(mockResetPasswordRepository);
  });

  tearDown(() => resetPasswordController.close());

  group('Controller Tests', () {
    blocTest('Should return a Success state',
        build: () {
          when(
            () => mockResetPasswordRepository.resetUserPassword(
                email: 'caio@caio.com'),
          ).thenAnswer(
              (_) async => state.copyWith(status: ResetPasswordStatus.success));
          return resetPasswordController;
        },
        act: (bloc) => bloc.resetUserPassword(email: 'caio@caio.com'),
        expect: () => [
              state.copyWith(status: ResetPasswordStatus.loading),
              state.copyWith(status: ResetPasswordStatus.success),
            ]);

    blocTest('Should return a Register error message',
        build: () {
          when(
            () => mockResetPasswordRepository.resetUserPassword(
                email: 'caio@caio.com'),
          ).thenAnswer((_) async => state.copyWith(
              status: ResetPasswordStatus.error, error: 'Register error'));
          return resetPasswordController;
        },
        act: (bloc) => bloc.resetUserPassword(email: 'caio@caio.com'),
        expect: () => [
              state.copyWith(status: ResetPasswordStatus.loading),
              state.copyWith(
                status: ResetPasswordStatus.error,
                error: 'Register error',
              ),
            ]);
  });
}
