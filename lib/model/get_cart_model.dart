// To parse this JSON data, do
//
//     final getCart = getCartFromJson(jsonString);

import 'dart:convert';

List<GetCart> getCartFromJson(String str) => List<GetCart>.from(json.decode(str).map((x) => GetCart.fromJson(x)));
class GetCart {
    GetCart({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.imageUrl,
        required this.user,
        required this.total,
    });

    final String id;
    final String name;
    final String description;
    final String price;
    final String imageUrl;
    final String user;
    final String total;

    factory GetCart.fromJson(Map<String, dynamic> json) => GetCart(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["image_url"],
        user: json["user"],
        total: json["total"],
    );

}
