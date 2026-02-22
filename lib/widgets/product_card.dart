import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/extensions/screen_size.dart';
import 'package:grocery/models/groceries_model.dart';
import 'package:grocery/services/database.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.products});

  final GroceriesModel products;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(20),
        color: AppColors().creamBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                products.thumbnail ?? 'no image',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  products.title ?? 'no title',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.screenHeight * 0.016, // 16
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  products.stock! == 0
                      ? "Out of stock"
                      : products.stock! < 10
                      ? "Low stock"
                      : "",
                  style: TextStyle(
                    fontSize: context.screenHeight * 0.01, //12
                    color: products.stock! == 0 || products.stock! < 10
                        ? Colors.red.shade400
                        : Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "\$ ${products.price ?? "unknouwn price"}",
                      style: TextStyle(
                        fontSize: context.screenHeight * 0.016, // 16
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    products.stock! == 0
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              DataBase().addToCart(
                                productId: products.id ?? 0,
                                price: products.price ?? 0,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '1 ${products.title ?? ""} added',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors().darkGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: AppColors().orange,
                                  behavior: SnackBarBehavior.floating,
                                  width: 150,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                height: context.screenHeight * 0.035,
                                width: context.screenHeight * 0.035,
                                decoration: BoxDecoration(
                                  color: AppColors().green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: context.screenHeight * 0.02,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
