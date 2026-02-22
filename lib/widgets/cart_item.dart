import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/data/products.dart';
import 'package:grocery/extensions/screen_size.dart';
import 'package:grocery/models/groceries_model.dart';
import 'package:grocery/services/database.dart';
import 'package:grocery/widgets/cart_counter.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});

  final Map item;

  @override
  Widget build(BuildContext context) {
    final localProduct = GroceriesModel.fromjson(
      LocalProducts.products.firstWhere(
        (products) => products['id'] == item['product_id'],
      ),
    );
    return Column(
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(color: AppColors().creamBg),
          child: Row(
            children: [
              Image.network(
                "${localProduct.thumbnail ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFE6P1LXtPr62C4PvWj1pF_740Wa3RKhyxFw&s"}",
                height: context.screenHeight * 0.1,
                width: context.screenHeight * 0.1, //120,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${localProduct.title}",
                    style: TextStyle(
                      fontSize: context.screenHeight * 0.016, // 16
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),

                  Text(
                    "\$ ${item['price'] * item['quantity']}",
                    style: TextStyle(
                      color: AppColors().green,
                      fontSize: context.screenHeight * 0.016, // 16
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  CartCounter(
                    icon: Icons.remove,
                    func: () => DataBase().removeFromCart(
                      productId: item['product_id'],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${item['quantity']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: context.screenHeight * 0.016, // 16
                    ),
                  ),
                  SizedBox(width: 8),
                  CartCounter(
                    icon: Icons.add,
                    func: () => DataBase().addToCart(
                      productId: item['product_id'],
                      price: item['price'],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(thickness: 0.5, height: 5, color: AppColors().grey.shade400),
      ],
    );
  }
}
