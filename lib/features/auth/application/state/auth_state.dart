import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final UserEntity? user;
  final String? errorMessage;
  final String? successMessage;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.errorMessage,
    this.successMessage,
  });

  factory AuthState.initial() => const AuthState(
    isLoading: false,
    user: null,
    errorMessage: null,
    successMessage: null,
  );

  AuthState copyWith({
    bool? isLoading,
    UserEntity? user,
    String? errorMessage,
    String? successMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, user, errorMessage, successMessage];
}
