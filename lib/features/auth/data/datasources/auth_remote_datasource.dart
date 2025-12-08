import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/core/errors/exceptions.dart';
import 'package:expense_tracker/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> logout();
  Future<void> sendEmailVerification();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<void> sendEmailVerification() async {
    final user = firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;
    if (user == null) {
      throw AuthException('Login failed');
    }

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      emailVerified: user.emailVerified,
    );
  }

  @override
  Future<UserModel> register(String email, String password) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;
    if (user == null) {
      throw AuthException('Registration failed');
    }

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      emailVerified: user.emailVerified,
    );
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
