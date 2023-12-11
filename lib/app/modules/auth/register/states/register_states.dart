// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, success, loading, error }

class RegisterStates extends Equatable {
  final RegisterStatus? status;
  final String? error;

  const RegisterStates({
    this.status = RegisterStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [status, error];

  RegisterStates copyWith({
    RegisterStatus? status,
    String? error,
  }) {
    return RegisterStates(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
