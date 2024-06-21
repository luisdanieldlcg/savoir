// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoundedTextInput extends StatelessWidget {
  final String hintText;

  final Icon leftIcon;
  final VoidCallback? onTap;
  final bool readonly;
  final Function(String)? onChanged;
  const RoundedTextInput({
    super.key,
    required this.hintText,
    required this.leftIcon,
    this.onTap,
    this.readonly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readonly,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: leftIcon,
        ),
      ),
    );
  }
}
