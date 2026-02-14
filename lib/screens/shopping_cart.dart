import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/data/products.dart';
import 'package:grocery/models/groceries_model.dart';
import 'package:grocery/services/database.dart';
import 'package:grocery/widgets/bottom_nav_bar.dart';
import 'package:grocery/widgets/cart_counter.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    // cart = Data
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.menu, color: Colors.white, size: 30),
        backgroundColor: AppColors().darkGreen,
        //centerTitle: true,
      ),
      backgroundColor: AppColors().darkGreen,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors().creamBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Order details",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors().black,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2, height: 1, color: AppColors().black),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: StreamBuilder(
                    stream: DataBase().supabase
                        .from('cart')
                        .stream(primaryKey: ['id'])
                        .eq(
                          'user_id',
                          DataBase().supabase.auth.currentUser!.id,
                        ),
                    builder: (context, asyncSnapshot) {
                      if (!asyncSnapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final cart = asyncSnapshot.data!;

                      return ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final localProduct = GroceriesModel.fromjson(
                            LocalProducts.products.firstWhere(
                              (products) =>
                                  products['id'] == cart[index]['product_id'],
                            ),
                          );
                          return Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors().creamBg,
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      "${localProduct.thumbnail ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFE6P1LXtPr62C4PvWj1pF_740Wa3RKhyxFw&s"}",
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${localProduct.title}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        Text(
                                          "\$ ${cart[index]['price'] * cart[index]['quantity']}",
                                          style: TextStyle(
                                            color: AppColors().green,
                                            fontSize: 18,
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
                                            productId:
                                                cart[index]['product_id'],
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${cart[index]['quantity']} kg',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        CartCounter(
                                          icon: Icons.add,
                                          func: () => DataBase().addToCart(
                                            productId:
                                                cart[index]['product_id'],
                                            price: cart[index]['price'],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                                height: 5,
                                color: AppColors().grey.shade400,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}
