import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:expense_tracker/features/auth/application/providers/auth_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Listen for auth state changes and redirect accordingly.
      ref.listen(authNotifierProvider, (previous, next) {
        // If user is logged in → go to home
        if (next.user != null) {
          context.go('/home');
        }

        // If user is NOT logged in → go to login
        if (next.user == null && !next.isLoading) {
          context.go('/login');
        }
      });
    });

    return Scaffold(
      body: Center(
        child: authState.isLoading
            ? const CircularProgressIndicator()
            : const CircularProgressIndicator(), // still show loader on splash
      ),
    );
  }
}
