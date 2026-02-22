import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/data/products.dart';
import 'package:grocery/models/groceries_model.dart';
import 'package:grocery/widgets/bottom_nav_bar.dart';
import 'package:grocery/widgets/offer_box.dart';
import 'package:grocery/widgets/product_card.dart';
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
      ),

      backgroundColor: AppColors().darkGreen,

      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----- search -----
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

              // ----- offer boxs -----
              OffersBox(),

              SizedBox(height: 40),
              // (((((((((((((Categories list)))))))))))))

              // ----- products list -----
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(products: products[index]);
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
