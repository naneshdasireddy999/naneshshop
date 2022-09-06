// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.datetime,
  });

  DateTime id;
  double amount;
  List<Products> products;
  DateTime datetime;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: DateTime.parse(json["id"]),
        amount: json["amount"].toDouble(),
        products: List<Products>.from(
            json["products"].map((x) => Products.fromJson(x))),
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toIso8601String(),
        "amount": amount,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "datetime": datetime.toIso8601String(),
      };
}

class Products {
  Products({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  String id;
  String title;
  int quantity;
  double price;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "quantity": quantity,
        "price": price,
      };
}
