// import 'dart:convert';

// import 'package:grocery/models/groceries_model.dart';
// import 'package:http/http.dart' as http;

// class Api {
//   String link = "https://dummyjson.com/products/category/groceries";
//   Future<List<GroceriesModel>> getData() async {
//     var uri = Uri.parse(link);
//     var response = await http.get(uri);
//     var result = jsonDecode(response.body);

//     List<GroceriesModel> productsList = [];
//     for (var element in result["products"]) {
//       productsList.add(GroceriesModel.fromjson(element));
//     }

//     return productsList;
//   }
// }
