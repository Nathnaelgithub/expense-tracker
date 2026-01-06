import 'package:flutter/material.dart';
import 'shake_widget.dart';

class AnimatedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool shake;

  const AnimatedPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.shake = false,
  });

  @override
  State<AnimatedPasswordField> createState() => _AnimatedPasswordFieldState();
}

class _AnimatedPasswordFieldState extends State<AnimatedPasswordField> {
  bool _obscure = true;
  bool _showEye = false;

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      shake: widget.shake,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscure,
        onChanged: (value) {
          setState(() {
            _showEye = value.isNotEmpty;
          });
        },
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
          suffixIcon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: _showEye
                ? GestureDetector(
                    key: const ValueKey("eye"),
                    onTap: () {
                      setState(() => _obscure = !_obscure);
                    },
                    onLongPressStart: (_) {
                      setState(() => _obscure = false);
                    },
                    onLongPressEnd: (_) {
                      setState(() => _obscure = true);
                    },
                    child: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade600,
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey("empty")),
          ),
        ),
      ),
    );
  }
}
