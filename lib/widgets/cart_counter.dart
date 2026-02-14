import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/extensions/screen_size.dart';

class CartCounter extends StatelessWidget {
  final IconData icon;
  final VoidCallback func;
  const CartCounter({super.key, required this.icon, required this.func});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        func();
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        height: context.screenHeight * 0.03,
        width: context.screenHeight * 0.03,
        decoration: BoxDecoration(
          color: AppColors().green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: context.screenHeight * 0.016,
        ),
      ),
    );
  }
}
