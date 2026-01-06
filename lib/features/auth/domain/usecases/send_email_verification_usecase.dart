import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/features/auth/domain/repositories/auth_repository.dart';

class SendEmailVerificationUseCase {
  final AuthRepository repository;

  SendEmailVerificationUseCase(this.repository);

  /// Returns a message if successful, or a failure if an error occurs
  Future<Either<AuthFailure, String>> call() async {
    try {
      await repository.sendEmailVerification();
      return const Right(
        "We sent a verification email. Please verify your email before logging in.",
      );
    } catch (e) {
      return Left(EmailVerificationFailure(e.toString()));
    }
  }
}
