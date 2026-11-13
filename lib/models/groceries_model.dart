/// Represents one grocery product (id, title, description, stock, price, image).
class GroceriesModel {
  int? id;
  String? title;
  String? description;
  double? stock;
  double? price;
  String? thumbnail;

  GroceriesModel({
    this.id,
    this.title,
    this.description,
    this.stock,
    this.price,
    this.thumbnail,
  });

  /// Creates a product from a JSON map. Stock and price are converted to double.
  factory GroceriesModel.fromjson(Map<String, dynamic> json) {
    return GroceriesModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      stock: (json['stock'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}
