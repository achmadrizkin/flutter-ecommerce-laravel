import 'dart:convert';

import 'package:flutter_ecommerce_laravel/model/get_cart_model.dart';
import 'package:flutter_ecommerce_laravel/model/get_products.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
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

  Future saveProduct(
      String name, LoginController model, String description, String imageURL, String price) async {
    final response = await http.post(
        Uri.parse(
            'https://achmadrizkin.my.id/flutter-store-app/public/api/products'),
        body: {
          "name": name,
          "userName": model.userDetails!.displayName,
          "userEmail": model.userDetails!.email,
          "description": description,
          "price": price,
          "image_url": imageURL,
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
        'https://achmadrizkin.my.id/flutter-store-app/public/api/products/' +
            id.toString()));

    return jsonDecode(response.body);
  }

 Future<List<GetCart>> getCartByUser(String query) async {
    final response = await http
        .get(Uri.parse('https://achmadrizkin.my.id/flutter-store-app/php/select_cart.php'));

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
    final response = await http
        .get(Uri.parse('https://achmadrizkin.my.id/flutter-store-app/php/select_products.php'));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite.map((json) => GetProduct.fromJson(json)).where((favorite) {
        final favoriteLower = favorite.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return favoriteLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<GetCart>> getCartByUserProducts(String query) async {
    final response = await http
        .get(Uri.parse('https://achmadrizkin.my.id/flutter-store-app/php/select_products.php'));

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
    final response = await http
        .get(Uri.parse('https://achmadrizkin.my.id/flutter-store-app/php/select_products.php'));

    if (response.statusCode == 200) {
      final List favorite = json.decode(response.body);
      return favorite.map((json) => GetProduct.fromJson(json)).where((favorite) {
        final favoriteLower = favorite.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return favoriteLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
