import 'package:bloc_test/bloc_test.dart';
import 'package:events4me/app/modules/auth/register/controller/register_controller.dart';
import 'package:events4me/app/modules/auth/register/repositories/register_repository.dart';
import 'package:events4me/app/modules/auth/register/states/register_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late RegisterController registerController;
  late MockRegisterRepository registerRepository;
  late RegisterStates state;

  setUp(() {
    state = RegisterStates();
    registerRepository = MockRegisterRepository();
    registerController = RegisterController(registerRepository);
  });

  tearDown(() => registerController.close());

  group('Register controller test API call states', () {
    blocTest(
      'should return a RegisterSuccess state',
      build: () {
        when(() => registerRepository.registerUser(
              userName: '',
              password: '',
              email: '',
              phone: '',
            )).thenAnswer(
          (_) async => state.copyWith(status: RegisterStatus.success),
        );
        return registerController;
      },
      act: (bloc) => bloc.registerUser(
        userName: '',
        password: '',
        email: '',
        phoneNumber: '',
      ),
      expect: () => [
        state.copyWith(status: RegisterStatus.loading),
        state.copyWith(status: RegisterStatus.success),
      ],
    );

    blocTest(
      'should return a RegisterError message',
      build: () {
        when(() => registerRepository.registerUser(
              userName: '',
              password: '',
              email: '',
              phone: '',
            )).thenAnswer(
          (_) async => state.copyWith(
            status: RegisterStatus.error,
            error: 'Register Error',
          ),
        );
        return registerController;
      },
      act: (bloc) => bloc.registerUser(
        userName: '',
        password: '',
        email: '',
        phoneNumber: '',
      ),
      expect: () => [
        state.copyWith(status: RegisterStatus.loading),
        state.copyWith(status: RegisterStatus.error, error: 'Register Error'),
      ],
    );
  });
}
