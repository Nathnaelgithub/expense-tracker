/// Domain entity representing an authenticated user
class UserEntity {
  final String id;

  /// Primary email used for authentication
  final String email;

  /// Indicates whether the user's email has been verified
  final bool emailVerified;

  /// User's real name (optional, set during profile creation)
  final String? name;

  /// Preferred display name shown in the UI (optional)
  final String? displayName;

  const UserEntity({
    required this.id,
    required this.email,
    required this.emailVerified,
    this.name,
    this.displayName,
  });
}
