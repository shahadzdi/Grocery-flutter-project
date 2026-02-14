import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/extensions/nav.dart';
import 'package:grocery/screens/products_list_screen.dart';
import 'package:grocery/screens/shopping_cart.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors().creamBg,
        unselectedItemColor: AppColors().lightGrenn,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        backgroundColor: AppColors().green,
        onTap: (index) {
          if (index == currentIndex) {
            return;
          }
          if (index == 0) {
            context.navAndClean(ProductsListScreen());
          } else if (index == 1) {
            context.navAndClean(ShoppingCart());
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: "products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
