import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:expense_tracker/features/auth/application/providers/auth_providers.dart';
import 'package:expense_tracker/features/auth/application/state/auth_state.dart';
import 'package:expense_tracker/core/utils/validators.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }

      // Navigate automatically on successful registration
      if (next.user != null && prev?.user != next.user) {
        context.go("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),
              TextFormField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: Validators.password,
              ),
              const SizedBox(height: 25),

              // --- Signup button with loading animation ---
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: authState.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(authNotifierProvider.notifier)
                                .register(
                                  emailCtrl.text.trim(),
                                  passCtrl.text.trim(),
                                );
                          }
                        },
                  child: authState.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Sign Up"),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => context.go("/login"),
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
