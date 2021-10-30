// To parse this JSON data, do
//
//     final getInvoice = getInvoiceFromJson(jsonString);

import 'dart:convert';

List<GetInvoice> getInvoiceFromJson(String str) =>
    List<GetInvoice>.from(json.decode(str).map((x) => GetInvoice.fromJson(x)));

String getInvoiceToJson(List<GetInvoice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetInvoice {
  GetInvoice({
    required this.id,
    required this.name,
    required this.userName,
    required this.userEmail,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.nameShop,
    required this.emailShop,
    required this.deliveryDetails,
    required this.totalBuy,
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
  final String nameShop;
  final String emailShop;
  final String deliveryDetails;
  final String totalBuy;

  factory GetInvoice.fromJson(Map<String, dynamic> json) => GetInvoice(
        id: json["id"],
        name: json["name"],
        userName: json["userName"],
        userEmail: json["userEmail"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        nameShop: json["nameShop"],
        emailShop: json["emailShop"],
        deliveryDetails: json["deliveryDetails"],
        totalBuy: json["totalBuy"],
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
        "nameShop": nameShop,
        "emailShop": emailShop,
        "deliveryDetails": deliveryDetails,
        "totalBuy": totalBuy,
      };
}
