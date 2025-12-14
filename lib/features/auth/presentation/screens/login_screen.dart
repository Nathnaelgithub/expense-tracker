import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:expense_tracker/features/auth/application/providers/auth_providers.dart';
import 'package:expense_tracker/features/auth/application/state/auth_state.dart';
import 'package:expense_tracker/core/utils/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(authNotifierProvider.notifier)
        .login(_emailCtrl.text.trim(), _passCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listen<AuthState>(authNotifierProvider, (prev, next) {
        // Show error messages
        if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
        }

        // when login is successful, navigate to home
        if (next.user != null && prev?.user?.id != next.user?.id) {
          context.go("/home");
        }
      });
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Email Field
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
                validator: Validators.email,
              ),

              const SizedBox(height: 12),

              /// Password Field
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: Validators.password,
              ),

              const SizedBox(height: 24),

              /// Login Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: authState.isLoading ? null : _onLogin,
                  child: authState.isLoading
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : const Text("Login"),
                ),
              ),

              const SizedBox(height: 16),

              /// Go to Register
              TextButton(
                onPressed: () => context.go("/signup"),
                child: const Text("Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
