import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/data/products.dart';
import 'package:grocery/models/groceries_model.dart';
import 'package:grocery/services/database.dart';
import 'package:grocery/widgets/bottom_nav_bar.dart';
import 'package:grocery/widgets/text_filed_widget.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final searchController = TextEditingController();
  List<GroceriesModel> products = [];

  @override
  void initState() {
    super.initState();
    for (var element in LocalProducts.products) {
      products.add(GroceriesModel.fromjson(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(
            color: AppColors().creamBg,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.menu, color: AppColors().creamBg, size: 30),
        backgroundColor: AppColors().darkGreen,
        //centerTitle: true,
      ),
      backgroundColor: AppColors().darkGreen,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "find your daily fresh grocery",
                style: TextStyle(color: AppColors().lightGrenn, fontSize: 20),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: TextFieldWidget(
                    controller: searchController,
                    hintText: "search for products",
                    prefixIcon: Icon(Icons.search),
                    fillColor: AppColors().creamBg,
                    hintTextColor: AppColors().darkGreen,
                    iconAndTextColor: AppColors().darkGreen,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // offer box
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors().green, Colors.lightGreen.shade200],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Fresh fruits",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "30% OFF",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppColors().creamBg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Image.asset(
                        "assets/images/vegetables.png",
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                ),
                itemBuilder: (context, index) {
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
                              products[index].thumbnail ?? 'no image',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].title ?? 'no title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                products[index].stock! == 0
                                    ? "Out of stock"
                                    : products[index].stock! < 10
                                    ? "Low stock"
                                    : "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      products[index].stock! == 0 ||
                                          products[index].stock! < 10
                                      ? Colors.red.shade400
                                      : Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$ ${products[index].price ?? "unknouwn price"}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  products[index].stock! == 0
                                      ? SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            DataBase().addToCart(
                                              productId:
                                                  products[index].id ?? 0,
                                              price: products[index].price ?? 0,
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '1 ${products[index].title ?? ""} added',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors().darkGreen,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    AppColors().orange,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                width: 150,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                duration: const Duration(
                                                  seconds: 1,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: AppColors().green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 30,
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
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
