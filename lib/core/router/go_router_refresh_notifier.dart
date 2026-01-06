import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

/// Wraps a Riverpod provider into a ChangeNotifier for GoRouter.
class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(WidgetRef ref, ProviderListenable<Object?> provider) {
    // Listen to provider changes
    ref.listen(provider, (_, _) => notifyListeners());
  }
}
