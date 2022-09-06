// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageurl,
    this.isfavourite = false,
  });

  String id;
  String title;
  String description;
  double price;
  String imageurl;
  bool isfavourite;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        imageurl: json["imageurl"],
        isfavourite: json["isfavourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imageurl": imageurl,
        "isfavourite": isfavourite,
      };
}
