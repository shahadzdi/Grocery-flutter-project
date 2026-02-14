import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  const NavButton({
    super.key,
    // required this.emailController,
    // required this.passwordController,
    // required this.mounted,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  // final bool mounted;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        minimumSize: const Size(double.infinity, 55),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
