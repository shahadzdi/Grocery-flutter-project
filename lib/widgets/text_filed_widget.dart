import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final Color fillColor;
  final Color iconAndTextColor;
  final Color hintTextColor;
  final String? errorText;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.fillColor,
    required this.iconAndTextColor,
    required this.hintTextColor,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: iconAndTextColor),
      decoration: InputDecoration(
        errorText: errorText,
        errorStyle: TextStyle(color: AppColors().error),
        filled: true,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        prefixIconColor: iconAndTextColor,
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: iconAndTextColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors().error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors().error, width: 2),
        ),
      ),
    );
  }
}
