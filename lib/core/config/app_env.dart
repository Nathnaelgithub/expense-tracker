import 'package:flutter/foundation.dart';

class AppEnv {
  static const bool useFirebaseEmulator = bool.fromEnvironment(
    'USE_FIREBASE_EMULATOR',
    defaultValue: false,
  );

  static const bool disableEmailVerification = bool.fromEnvironment(
    'DISABLE_EMAIL_VERIFICATION',
    defaultValue: false,
  );

  static bool get shouldVerifyEmail => !kDebugMode && !disableEmailVerification;
}
