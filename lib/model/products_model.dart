// To parse this JSON data, do
//
//     final barang = barangFromJson(jsonString);

import 'dart:convert';

Barang barangFromJson(String str) => Barang.fromJson(json.decode(str));

String barangToJson(Barang data) => json.encode(data.toJson());

class Barang {
  Barang({
    required this.message,
    required this.data,
  });

  final String message;
  final List<Datum> data;

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
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

  final int id;
  final String name;
  final String userName;
  final String userEmail;
  final String description;
  final String price;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
