import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/services/database.dart';
import 'package:grocery/widgets/bottom_nav_bar.dart';
import 'package:grocery/widgets/cart_item.dart';
import 'package:grocery/widgets/nav_button.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  // ----- calc total price -----
  double calculateTotal(List<Map> cart) {
    double totalPrice = 0;
    for (var item in cart) {
      totalPrice += item['price'] * item['quantity'];
    }
    return totalPrice;
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
        // ----- base container -----
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
              // ------ order detailes container ------
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

              // ----- cart list -----
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

                    // ===== empty cart case ======
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
                    // ===== list items builder
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                              itemCount: cart.length,
                              itemBuilder: (context, index) {
                                return CartItem(item: cart[index]);
                              },
                            ),
                          ),
                        ),

                        // === Total and checkout ===
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
                              // total
                              Text(
                                'Total = \$ ${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: AppColors().black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 20),
                              // checkout
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
