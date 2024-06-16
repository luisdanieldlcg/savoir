import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final VoidCallback? onTap;
  final bool readOnly;

  const TextInput({
    super.key,
    this.hintText = "",
    this.controller,
    this.validator,
    this.obscureText = false,
    required this.keyboardType,
    this.decoration,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly,
      decoration: decoration ?? InputDecoration(hintText: hintText),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Este campo es requerido";
        }

        if (keyboardType == TextInputType.emailAddress) {
          final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
          if (!emailRegex.hasMatch(value)) {
            return "Correo electrónico inválido";
          }
        }

        if (keyboardType == TextInputType.visiblePassword) {
          if (value.length < 6) {
            return "La contraseña debe tener al menos 6 caracteres";
          }
        }

        if (keyboardType == TextInputType.phone) {
          final phoneRegex = RegExp(r"^\d{10}$");
          if (!phoneRegex.hasMatch(value)) {
            return "Número de teléfono inválido";
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
