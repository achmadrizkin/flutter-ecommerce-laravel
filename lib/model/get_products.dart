// To parse this JSON data, do
//
//     final getProduct = getProductFromJson(jsonString);

import 'dart:convert';

List<GetProduct> getProductFromJson(String str) =>
    List<GetProduct>.from(json.decode(str).map((x) => GetProduct.fromJson(x)));

class GetProduct {
  GetProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
