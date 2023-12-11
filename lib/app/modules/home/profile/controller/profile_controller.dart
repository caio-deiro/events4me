import 'package:bloc/bloc.dart';
import 'package:events4me/app/modules/home/profile/repositories/profile_repository_impl.dart';
import 'package:events4me/app/modules/home/profile/states/profile_states.dart';

class ProfileController extends Cubit<ProfileStates> {
  final ProfileRepositoryImpl repository;
  ProfileController(this.repository) : super(ProfileStates());

  Future<void> updateProfile({required String phone}) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final response = await repository.updateProfile(phone: phone);
    emit(response);
  }
}
