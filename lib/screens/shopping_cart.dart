import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/data/products.dart';
import 'package:grocery/extensions/screen_size.dart';
import 'package:grocery/models/groceries_model.dart';
import 'package:grocery/services/database.dart';
import 'package:grocery/widgets/bottom_nav_bar.dart';
import 'package:grocery/widgets/cart_counter.dart';
import 'package:grocery/widgets/nav_button.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double calculateTotal(List<Map> cart) {
    double total_price = 0;
    for (var item in cart) {
      total_price += item['price'] * item['quantity'];
    }
    return total_price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping cart',
          style: TextStyle(
            color: AppColors().creamBg,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.menu, color: AppColors().creamBg, size: 30),
        backgroundColor: AppColors().darkGreen,
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Order details",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppColors().darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2, height: 1, color: AppColors().darkGreen),
              Expanded(
                child: StreamBuilder(
                  stream: DataBase().supabase
                      .from('cart')
                      .stream(primaryKey: ['id'])
                      .order('product_id'),
                  builder: (context, asyncSnapshot) {
                    if (!asyncSnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors().orange,
                        ),
                      );
                    }

                    final cart = asyncSnapshot.data!;
                    double total = calculateTotal(cart);

                    if (cart.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          "Your cart is empty",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors().grey,
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                              itemCount: cart.length,
                              itemBuilder: (context, index) {
                                final localProduct = GroceriesModel.fromjson(
                                  LocalProducts.products.firstWhere(
                                    (products) =>
                                        products['id'] ==
                                        cart[index]['product_id'],
                                  ),
                                );
                                return Column(
                                  children: [
                                    Container(
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: AppColors().creamBg,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            "${localProduct.thumbnail ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFE6P1LXtPr62C4PvWj1pF_740Wa3RKhyxFw&s"}",
                                            height: context.screenHeight * 0.1,
                                            width:
                                                context.screenHeight *
                                                0.1, //120,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${localProduct.title}",
                                                style: TextStyle(
                                                  fontSize:
                                                      context.screenHeight *
                                                      0.016, // 16
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 6),

                                              Text(
                                                "\$ ${cart[index]['price'] * cart[index]['quantity']}",
                                                style: TextStyle(
                                                  color: AppColors().green,
                                                  fontSize:
                                                      context.screenHeight *
                                                      0.016, // 16
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
                                                func: () =>
                                                    DataBase().removeFromCart(
                                                      productId:
                                                          cart[index]['product_id'],
                                                    ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                '${cart[index]['quantity']}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      context.screenHeight *
                                                      0.016, // 16
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
                            ),
                          ),
                        ),
                        Container(
                          height: 90,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors().creamBg,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            border: BoxBorder.fromLTRB(
                              top: BorderSide(
                                color: AppColors().grey,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total = \$ ${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: AppColors().black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: NavButton(
                                  text: "Checkout",
                                  backgroundColor: AppColors().orange,
                                  textColor: AppColors().darkGreen,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
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
