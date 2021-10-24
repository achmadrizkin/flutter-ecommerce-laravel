// To parse this JSON data, do
//
//     final GetProduct = GetProductsFromJson(jsonString);

import 'dart:convert';

List<GetProduct> GetProductsFromJson(String str) => List<GetProduct>.from(json.decode(str).map((x) => GetProduct.fromJson(x)));

String GetProductsToJson(List<GetProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProduct {
    GetProduct({
        required this.id,
        required this.name,
        required this.userName,
        required this.userEmail,
        required this.description,
        required this.price,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String name;
    final String userName;
    final String userEmail;
    final String description;
    final String price;
    final String imageUrl;
    final String createdAt;
    final String updatedAt;

    factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
        id: json["id"],
        name: json["name"],
        userName: json["userName"],
        userEmail: json["userEmail"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userName": userName,
        "userEmail": userEmail,
        "description": description,
        "price": price,
        "image_url": imageUrl,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
