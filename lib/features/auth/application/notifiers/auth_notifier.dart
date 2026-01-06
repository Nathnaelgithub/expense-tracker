import 'package:expense_tracker/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_tracker/features/auth/domain/usecases/login_usecase.dart';
import 'package:expense_tracker/features/auth/domain/usecases/logout_usecase.dart';
import 'package:expense_tracker/features/auth/domain/usecases/register_usecase.dart';

import 'package:expense_tracker/features/auth/application/state/auth_state.dart';
import 'package:expense_tracker/core/providers/providers.dart';
import 'package:expense_tracker/core/config/app_env.dart';
import 'package:flutter/foundation.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  // ====== Dependencies ======
  LoginUseCase get _loginUseCase => ref.read(loginUseCaseProvider);
  RegisterUseCase get _registerUseCase => ref.read(registerUseCaseProvider);
  LogoutUseCase get _logoutUseCase => ref.read(logoutUseCaseProvider);
  SendEmailVerificationUseCase get _sendEmailVerificationUseCase =>
      ref.read(sendEmailVerificationUseCaseProvider);

  // ====== Actions ======

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    debugPrint('🌀 LOGIN STARTED');

    final result = await _loginUseCase(LoginParams(email, password));

    result.fold(
      (failure) {
        debugPrint('❌ LOGIN FAILED: ${failure.message}');

        state = state.copyWith(isLoading: false, errorMessage: failure.message);

        debugPrint('🌀 isLoading = ${state.isLoading}');
      },
      (user) {
        debugPrint('✅ LOGIN SUCCESS: ${user.email}');

        state = state.copyWith(isLoading: false, user: user);

        debugPrint('🌀 isLoading = ${state.isLoading}');
      },
    );
  }

  Future<void> register(String email, String password) async {
    state = state.copyWith(isLoading: true);

    debugPrint('🌀 REGISTER STARTED');

    final result = await _registerUseCase(RegisterParams(email, password));

    result.fold(
      (failure) {
        debugPrint('❌ REGISTER FAILED: ${failure.message}');

        state = state.copyWith(isLoading: false, errorMessage: failure.message);

        debugPrint('🌀 isLoading = ${state.isLoading}');
      },

      (user) {
        debugPrint('✅ REGISTER SUCCESS: ${user.email}');

        state = state.copyWith(isLoading: false, user: user);

        debugPrint('🌀 isLoading = ${state.isLoading}');

        if (!AppEnv.disableEmailVerification) {
          _sendEmailVerificationUseCase();
        }
      },
    );
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    final result = await _logoutUseCase(NoParams());

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (_) => state = AuthState.initial(),
    );
  }
}
