import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:expense_tracker/features/auth/domain/repositories/auth_repository.dart';

import 'package:expense_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:expense_tracker/core/config/app_env.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AuthFailure, void>> sendEmailVerification() async {
    try {
      await remoteDataSource.sendEmailVerification();
      return const Right(null);
    } catch (e) {
      return Left(LoginFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      if (AppEnv.shouldVerifyEmail && !userModel.emailVerified) {
        return Left(
          LoginFailure("Email not verified. Please verify your email."),
        );
      }
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(LoginFailure(e.message ?? "Invalid email or password"));
    } catch (e) {
      return Left(LoginFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> register(
    String email,
    String password,
  ) async {
    try {
      final userModel = await remoteDataSource.register(email, password);
      await sendEmailVerification();
      return Right(userModel);
    } catch (e) {
      return Left(RegisterFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(LogoutFailure(e.toString()));
    }
  }
}
