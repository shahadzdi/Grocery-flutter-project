class GroceriesModel {
  int? id;
  String? title;
  String? description;
  double? stock;
  double? price;
  double? rating;
  String? thumbnail;

  GroceriesModel({
    this.id,
    this.title,
    this.description,
    this.stock,
    this.price,
    this.rating,
    this.thumbnail,
  });

  factory GroceriesModel.fromjson(Map<String, dynamic> json) {
    return GroceriesModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      stock: json['stock'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      rating: json['rating'],
    );
  }
}
