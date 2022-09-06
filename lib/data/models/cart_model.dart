// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cartitem> cartFromJson(String str) =>
    List<Cartitem>.from(json.decode(str).map((x) => Cartitem.fromJson(x)));

String cartToJson(List<Cartitem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cartitem {
  Cartitem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  String id;
  String title;
  int quantity;
  double price;

  factory Cartitem.fromJson(Map<String, dynamic> json) => Cartitem(
        id: json["id"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "quantity": quantity,
        "price": price,
      };
}
