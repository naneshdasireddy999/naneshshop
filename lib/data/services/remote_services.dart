import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naneshshop/data/models/cart_model.dart';
import 'package:naneshshop/data/models/order_model.dart';
import 'package:naneshshop/data/models/product_model.dart';
import 'package:naneshshop/modules/cart/views/cart.dart';

class RemoteServices {
  static var client = http.Client();
  static Future<List<Product>?> fetchproducts() async {
    try {
      var response =
          await client.get(Uri.parse('http://localhost:3000/products'));
      if (response.statusCode == 200) {
        var jsonstring = response.body;
        return productFromJson(jsonstring);
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<List<Product>?> fetchproductsfromfirebase() async {
    List<Product> p = [];
    try {
      var response = await client.get(Uri.parse(
          'https://flashchat-f8dbf-default-rtdb.firebaseio.com/products.json'));
      if (response.statusCode == 200) {
        final extracteddata =
            json.decode(response.body) as Map<String, dynamic>?;
        if (extracteddata == null) {
          return p;
        } else {
          extracteddata.forEach((key, value) {
            p.add(Product(
                id: key,
                title: value['title'],
                isfavourite: value['isfavourite'],
                description: value['description'],
                price: value['price'],
                imageurl: value['imageurl']));
          });
          return p;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<List<Order>?> fetchorders() async {
    List<Order> l = [];
    try {
      var response = await client.get(Uri.parse(
          'https://flashchat-f8dbf-default-rtdb.firebaseio.com/orders.json'));
      if (response.statusCode == 200) {
        final extracteddata =
            json.decode(response.body) as Map<String, dynamic>?;
        if (extracteddata == null) {
          return l;
        } else {
          extracteddata.forEach((key, value) {
            l.add(Order(
                id: DateTime.now(),
                amount: value['amount'],
                products: (value['products'] as List<dynamic>)
                    .map((e) => Products(
                        id: e['id'],
                        title: e['title'],
                        quantity: e['quantity'],
                        price: e['price']))
                    .toList(),
                datetime: DateTime.parse(value['datetime'])));
          });
          return l;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> editcartitems(String id, int quantity) async {
    try {
      var response = await client.patch(
        Uri.parse('http://localhost:3000/cart/$id'),
        body: jsonEncode({"quantity": quantity + 1}),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> editcartitemsinfirebase(String id, int quantity) async {
    try {
      print('halo');
      var response = await client.patch(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/cart/$id.json'),
        body: jsonEncode({"quantity": quantity + 1}),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> editmycartitems(String id, int quantity) async {
    try {
      print('halo');
      var response = await client.patch(
        Uri.parse('http://localhost:3000/cart/$id'),
        body: jsonEncode({"quantity": quantity - 1}),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> editmycartitemsinfirebase(String id, int quantity) async {
    try {
      print('halo');
      var response = await client.patch(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/cart/$id.json'),
        body: jsonEncode({"quantity": quantity - 1}),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> deletecart(String z1) async {
    try {
      await client.delete(
        Uri.parse('http://localhost:3000/cart/$z1'),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> deletecartinfirebase(String z1) async {
    try {
      await client.delete(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/cart/$z1.json'),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<List<Cartitem>?> fetchcartitems() async {
    try {
      var response = await client.get(Uri.parse('http://localhost:3000/cart'));
      if (response.statusCode == 200) {
        var jsonstring = response.body;
        return cartFromJson(jsonstring);
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<List<Cartitem>?> fetchcartitemsfromfirebase() async {
    List<Cartitem> cl = [];
    try {
      var response = await client.get(Uri.parse(
          'https://flashchat-f8dbf-default-rtdb.firebaseio.com/cart.json'));

      if (response.statusCode == 200) {
        final extracteddata =
            json.decode(response.body) as Map<String, dynamic>?;
        if (extracteddata == null) {
          return cl;
        } else {
          extracteddata.forEach((key, value) {
            cl.add(Cartitem(
                id: key,
                title: value['title'],
                quantity: value['quantity'],
                price: value['price']));
          });

          return cl;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> deletecartitem(String id) async {
    try {
      await client.delete(
        Uri.parse('http://localhost:3000/cart/$id'),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> deletecartiteminfirebase(String id) async {
    try {
      await client.delete(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/cart/$id.json'),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> changefavourite(String id, Product p) async {
    try {
      print(p.isfavourite);
      var response = await client.patch(
        Uri.parse('http://localhost:3000/products/$id'),
        body: jsonEncode({
          "isfavourite": !p.isfavourite,
        }),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> changefavouriteinfirebase(String id, Product p) async {
    try {
      print(p.isfavourite);
      var response = await client.patch(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/products/$id.json'),
        body: jsonEncode({
          "isfavourite": !p.isfavourite,
        }),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> addnewproduct(
      String title, String description, double price, String imageurl) async {
    try {
      var response = await client.post(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/products.json'),
        body: json.encode({
          "id": DateTime.now().toString(),
          "title": title,
          "description": description,
          "price": price,
          "imageurl": imageurl,
          "isfavourite": false
        }),
      );
      // await client.post(
      //   Uri.parse('http://localhost:3000/products/'),
      //   body: jsonEncode({
      //     "id": DateTime.now().toString(),
      //     "title": title,
      //     "description": description,
      //     "price": price,
      //     "imageurl": imageurl,
      //     "isfavourite": false
      //   }),
      //   headers: {"Content-type": "application/json"},
      // );
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addcartitem(
      String productid, double price, String title) async {
    try {
      var response = await client.post(
        Uri.parse('http://localhost:3000/cart/'),
        body: jsonEncode(
            {"id": productid, "title": title, "quantity": 1, "price": price}),
        headers: {"Content-type": "application/json"},
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addcartiteminfirebase(
      String productid, double price, String title) async {
    try {
      var response = await client.put(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/cart/$productid.json'),
        body: jsonEncode(
            {"id": productid, "title": title, "quantity": 1, "price": price}),
        headers: {"Content-type": "application/json"},
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addorderitem(List<Cartitem> cl, double total) async {
    try {
      print(total);
      var response = await client.post(
        Uri.parse('http://localhost:3000/order/'),
        body: jsonEncode({
          "id": DateTime.now().toString(),
          "amount": total,
          "products": cl,
          "datetime": DateTime.now().toString()
        }),
        headers: {"Content-type": "application/json"},
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addorderiteminfirebase(
      List<Cartitem> cl, double total) async {
    try {
      print(total);
      var response = await client.post(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/orders.json'),
        body: jsonEncode({
          "id": DateTime.now().toString(),
          "amount": total,
          "products": cl,
          "datetime": DateTime.now().toString()
        }),
        headers: {"Content-type": "application/json"},
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<void> deleteproducts(int id) async {
    try {
      var response = await client.delete(
        Uri.parse('http://localhost:3000/products/$id'),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> deleteproductsinfirebase(String id) async {
    try {
      var response = await client.delete(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/products/$id.json'),
      );
      print('isdeleted');
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> editproduct(String? id, String title, String description,
      double price, String imageurl) async {
    try {
      print(id);
      var response = await client.patch(
        Uri.parse('http://localhost:3000/products/$id'),
        body: jsonEncode({
          "title": title,
          "description": description,
          "price": price,
          "imageurl": imageurl,
        }),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> editproductinfirebase(String? id, String title,
      String description, double price, String imageurl) async {
    try {
      print(id);
      var response = await client.patch(
        Uri.parse(
            'https://flashchat-f8dbf-default-rtdb.firebaseio.com/products/$id.json'),
        body: jsonEncode({
          "title": title,
          "description": description,
          "price": price,
          "imageurl": imageurl,
        }),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  static Future<void> deleteproduct(String id) async {
    try {
      var response = await client.delete(
        Uri.parse('http://localhost:3000/products/$id'),
        headers: {"Content-type": "application/json"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }
}
