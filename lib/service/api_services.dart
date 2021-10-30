import 'dart:convert';

import 'package:flutter_ecommerce_laravel/model/get_cart_model.dart';
import 'package:flutter_ecommerce_laravel/model/get_invoice.dart';
import 'package:flutter_ecommerce_laravel/model/get_products.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // get data from API
  Future<Barang> getData() async {
    final response = await http.get(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/public/api/products/'));

    if (response.statusCode == 200) {
      return Barang.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  Future saveProduct(String name, String userName, String userEmail,
      String description, String imageURL, String price) async {
    final response = await http.post(
        Uri.parse(
            'https://achmadrizkin.my.id/flutter-store-app/public/api/products'),
        body: {
          "name": name,
          "userName": userName,
          "userEmail": userEmail,
          "description": description,
          "price": price,
          "image_url": imageURL,
        });

    return jsonDecode(response.body);
  }

  Future saveInvoice(
      String name,
      String userName,
      String userEmail,
      String description,
      String imageURL,
      String price,
      String nameShop,
      String emailShop,
      String deliveryDetails,
      String totalBuy) async {
    final response = await http.post(
        Uri.parse(
            'https://achmadrizkin.my.id/flutter-store-app/public/api/invoice'),
        body: {
          "name": name,
          "userName": userName,
          "userEmail": userEmail,
          "description": description,
          "price": price,
          "image_url": imageURL,
          "nameShop": nameShop,
          "emailShop": emailShop,
          "deliveryDetails": deliveryDetails,
          "totalBuy": totalBuy,
        });

    return jsonDecode(response.body);
  }

  Future saveCart(
      String name,
      String userName,
      String userEmail,
      String description,
      String imageURL,
      String price,
      String nameShop,
      String emailShop) async {
    final response = await http.post(
        Uri.parse(
            'https://achmadrizkin.my.id/flutter-store-app/public/api/cart'),
        body: {
          "name": name,
          "userName": userName,
          "userEmail": userEmail,
          "description": description,
          "price": price,
          "image_url": imageURL,
          "nameShop": nameShop,
          "emailShop": emailShop,
        });

    return jsonDecode(response.body);
  }

  Future updateProduct(String name, String description, String imageURL,
      String price, int id) async {
    final response = await http.put(
        Uri.parse(
            'https://achmadrizkin.my.id/flutter-store-app/public/api/products/' +
                id.toString()),
        body: {
          "name": name,
          "description": description,
          "price": price,
          "image_url": imageURL,
        });

    return jsonDecode(response.body);
  }

  Future deleteProduct(int id) async {
    final response = await http.delete(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/public/api/invoice/' +
            id.toString()));

    return jsonDecode(response.body);
  }

  Future deleteProductInvoice(int id) async {
    final response = await http.delete(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/public/api/invoice/' +
            id.toString()));

    return jsonDecode(response.body);
  }

  Future<List<GetCart>> getCartByUser(String query) async {
    final response = await http.get(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/php/select_cart.php'));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite.map((json) => GetCart.fromJson(json)).where((favorite) {
        final favoriteLower = favorite.userEmail.toLowerCase();
        final searchLower = query.toLowerCase();

        return favoriteLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<GetProduct>> getByProduct(String query) async {
    final response = await http.get(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/php/select_products.php'));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite
          .map((json) => GetProduct.fromJson(json))
          .where((favorite) {
        final favoriteLower = favorite.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return favoriteLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<GetCart>> getCartByUserProducts(String query) async {
    final response = await http.get(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/php/select_products.php'));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite.map((json) => GetCart.fromJson(json)).where((favorite) {
        final favoriteLower = favorite.userEmail.toLowerCase();
        final searchLower = query.toLowerCase();

        return favoriteLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<GetProduct>> searchProduct(String query) async {
    final response = await http.get(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/php/select_products.php'));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite
          .map((json) => GetProduct.fromJson(json))
          .where((favorite) {
        final favoriteLower = favorite.name.toLowerCase();
        final shopLower = favorite.userName.toLowerCase();
        final searchLower = query.toLowerCase();

        return favoriteLower.contains(searchLower) ||
            shopLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<GetInvoice>> selectInvoice(String query) async {
    final response = await http.get(Uri.parse(
        'https://achmadrizkin.my.id/flutter-store-app/php/select_invoice.php'));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite
          .map((json) => GetInvoice.fromJson(json))
          .where((favorite) {
        final favoriteLower = favorite.name.toLowerCase();
        final shopLower = favorite.userName.toLowerCase();
        final searchLower = query.toLowerCase();

        return favoriteLower.contains(searchLower) ||
            shopLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<GetProduct>> getUserProduct(String query) async {
    final response = await http.get(Uri.parse(
        "https://achmadrizkin.my.id/flutter-store-app/php/select_products.php"));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite
          .map((json) => GetProduct.fromJson(json))
          .where((favorite) {
        final shopLower = favorite.userEmail.toLowerCase();
        final searchLower = query.toLowerCase();

        return shopLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<GetInvoice>> getInvoiceByUser(String query) async {
    final response = await http.get(Uri.parse(
        "https://achmadrizkin.my.id/flutter-store-app/php/select_invoice.php"));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite
          .map((json) => GetInvoice.fromJson(json))
          .where((favorite) {
        final shopLower = favorite.userEmail.toLowerCase();
        final searchLower = query.toLowerCase();

        return shopLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  // Future saveCart(
  //     String name, String userName, String userEmail, String description, String imageURL, String price) async {
  //   final response = await http.post(
  //       Uri.parse(
  //           'https://achmadrizkin.my.id/flutter-store-app/public/api/cart'),
  //       body: {
  //         "name": name,
  //         "userName": userName,
  //         "userEmail": userEmail,
  //         "description": description,
  //         "price": price,
  //         "image_url": imageURL,
  //       });

  //   return jsonDecode(response.body);
  // }
}
