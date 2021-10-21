import 'dart:convert';

import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // get data from API
  Future<Barang> getData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8001/api/products'));

    if (response.statusCode == 200) {
      return Barang.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  Future saveProduct(
      String name, String description, String imageURL, String price) async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8001/api/products'), body: {
      "name": name,
      "description": description,
      "price": price,
      "image_url": imageURL,
    });

    return jsonDecode(response.body);
  }
}
