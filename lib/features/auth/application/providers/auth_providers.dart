import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// Import Notifier + State
import 'package:expense_tracker/features/auth/application/notifiers/auth_notifier.dart';
import 'package:expense_tracker/features/auth/application/state/auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

final authListenableProvider = Provider<ChangeNotifier>((ref) {
  final listenable = _AuthListenable();
  ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    listenable.trigger();
  });
  ref.onDispose(() {
    listenable.dispose();
  });
  return listenable;
});

class _AuthListenable extends ChangeNotifier {
  _AuthListenable();

  void trigger() {
    notifyListeners();
  }
}
