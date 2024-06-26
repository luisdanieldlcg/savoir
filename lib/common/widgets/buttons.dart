// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool disabled;
  final IconData? rightIcon;
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 45,
    this.disabled = false,
    this.rightIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        child: rightIcon == null
            ? Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(width: 12),
                  Icon(rightIcon, color: Colors.white),
                ],
              ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool disabled;
  const SecondaryButton({
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 45,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: disabled ? null : onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
