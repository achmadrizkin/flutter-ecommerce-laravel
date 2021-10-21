// To parse this JSON data, do
//
//     final barang = barangFromJson(jsonString);

import 'dart:convert';

Barang barangFromJson(String str) => Barang.fromJson(json.decode(str));

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
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );
}
