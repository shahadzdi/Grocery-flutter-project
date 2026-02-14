import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';

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
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: AppColors().green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
