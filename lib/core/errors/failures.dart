/// Failures are used at the domain layer.
/// They wrap exceptions in a UI-safe format.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server Failure"]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache Failure"]);
}

/// Auth failures
abstract class AuthFailure extends Failure {
  const AuthFailure([super.message = "Authentication Failure"]);
}

/// Specific auth failures
class LoginFailure extends AuthFailure {
  const LoginFailure([super.message = "Login Failure"]);
}

class RegisterFailure extends AuthFailure {
  const RegisterFailure([super.message = "Register Failure"]);
}

class EmailVerificationFailure extends AuthFailure {
  const EmailVerificationFailure([
    super.message = "Email Verification Failure",
  ]);
}

class LogoutFailure extends AuthFailure {
  const LogoutFailure([super.message = "Logout Failure"]);
}
