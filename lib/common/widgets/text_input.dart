import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String)? validator;
  final bool obscureText;
  final TextInputType keyboardType;

  const TextInput({
    super.key,
    required this.labelText,
    this.controller,
    this.validator,
    this.obscureText = false,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "This field is required";
        }

        if (keyboardType == TextInputType.emailAddress) {
          final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
          if (!emailRegex.hasMatch(value)) {
            return "Invalid email address";
          }
        }

        if (keyboardType == TextInputType.visiblePassword) {
          if (value.length < 6) {
            return "Password must be at least 6 characters long";
          }
        }

        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
    );
  }
}
