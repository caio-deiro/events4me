import 'package:bloc_test/bloc_test.dart';
import 'package:events4me/app/modules/home/profile/controller/profile_controller.dart';
import 'package:events4me/app/modules/home/profile/repositories/profile_repository_impl.dart';
import 'package:events4me/app/modules/home/profile/states/profile_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ProfileRepositoryMock extends Mock implements ProfileRepositoryImpl {}

void main() {
  late ProfileController controller;
  late ProfileRepositoryMock repository;
  late ProfileStates state;

  setUp(() {
    state = ProfileStates();
    repository = ProfileRepositoryMock();
    controller = ProfileController(repository);
  });

  tearDown(() => controller.close());
  group('Profile controller tests', () {
    blocTest(
      'Should return a profile status success',
      build: () {
        when(
          () => repository.updateProfile(phone: '123456'),
        ).thenAnswer(
            (_) async => state.copyWith(status: ProfileStatus.success));
        return controller;
      },
      act: (bloc) => bloc.updateProfile(phone: '123456'),
      expect: () => [
        state.copyWith(status: ProfileStatus.loading),
        state.copyWith(status: ProfileStatus.success),
      ],
    );
    blocTest(
      'Should return a profile status error',
      build: () {
        when(
          () => repository.updateProfile(phone: '123456'),
        ).thenAnswer((_) async => state.copyWith(
            status: ProfileStatus.error, error: 'Profile error'));
        return controller;
      },
      act: (bloc) => bloc.updateProfile(phone: '123456'),
      expect: () => [
        state.copyWith(status: ProfileStatus.loading),
        state.copyWith(status: ProfileStatus.error, error: 'Profile error'),
      ],
    );
  });
}
