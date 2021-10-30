// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_cart_model.dart';
import 'package:flutter_ecommerce_laravel/model/get_products.dart';
import 'package:flutter_ecommerce_laravel/pages/product_details/product_getProduct.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class ProductRecomendation2 extends StatefulWidget {
  const ProductRecomendation2({Key? key, required this.data}) : super(key: key);

  final GetProduct data;

  @override
  State<ProductRecomendation2> createState() => _ProductRecomendation2State();
}

class _ProductRecomendation2State extends State<ProductRecomendation2> {
  List<GetCart> cart = [];
  String? query = "a";
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    query = widget.data.userEmail;

    init();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future searchBook(String query) async => debounce(() async {
        final cart = await ApiServices().getCartByUserProducts(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.cart = cart;
        });
      });

  Future init() async {
    final cart = await ApiServices().getCartByUserProducts(query!);

    setState(() => this.cart = cart);
  }

  @override
  Widget build(BuildContext context) {
    //
    Widget buildBook(GetCart music) => ListTile(
          leading: music.imageUrl == null
              ? SizedBox(height: 5)
              : Image.network(music.imageUrl),
          title: Text(music.name, style: TextStyle(color: Colors.white)),
          subtitle:
              Text(music.description, style: TextStyle(color: Colors.white)),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        );

    return FutureBuilder<List<GetCart>>(
      future: ApiServices().getCartByUserProducts(query!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final data = cart[index];

                return Container(
                  color: black,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductGetProductDetails(
                                  data: widget.data,
                                )),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: MediaQuery.of(context).size.height / 2 - 10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: black,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                data.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(data.name,
                                    style: headingStyle2.copyWith(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis)),
                                AutoSizeText("\$ ${data.price}",
                                    style: subTitleTextStyle.copyWith(
                                        color: Colors.grey,
                                        fontSize: 5,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return PlayStoreShimmer(
            hasCustomColors: true,
            colors: [
              grey,
              // light color
              white,
              // Medium color
              grey,
            ],
          );
        }
      },
    );
  }
}
