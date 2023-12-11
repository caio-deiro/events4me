// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum ResetPasswordStatus { initial, loading, success, error }

class ResetPasswordStates extends Equatable {
  final ResetPasswordStatus status;
  final String? error;

  const ResetPasswordStates({
    this.error,
    this.status = ResetPasswordStatus.initial,
  });
  @override
  List<Object?> get props => [error, status];

  ResetPasswordStates copyWith({
    ResetPasswordStatus? status,
    String? error,
  }) {
    return ResetPasswordStates(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
