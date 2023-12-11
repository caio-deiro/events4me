// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:events4me/app/shared/services/user/user_model.dart';

enum ProfileStatus { initial, loading, success, error }

// ignore: must_be_immutable
class ProfileStates extends Equatable {
  ProfileStatus status;
  String? error;
  UserModel? user;

  ProfileStates({
    this.status = ProfileStatus.initial,
    this.error,
    this.user,
  });

  @override
  List<Object?> get props => [status, error, user];

  ProfileStates copyWith({
    ProfileStatus? status,
    String? error,
    UserModel? user,
  }) {
    return ProfileStates(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
