/// Exceptions come from data sources (Firebase, APIs, Local DB)
/// They are low-level errors — not shown to UI directly.
class ServerException implements Exception {}

class CacheException implements Exception {}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}
