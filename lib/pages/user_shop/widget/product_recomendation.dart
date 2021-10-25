// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_cart_model.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/pages/product_details/product_details.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class ProductRecomendation extends StatefulWidget {
  const ProductRecomendation({Key? key, required this.data}) : super(key: key);

  final Datum data;

  @override
  State<ProductRecomendation> createState() => _ProductRecomendationState();
}

class _ProductRecomendationState extends State<ProductRecomendation> {
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
                            builder: (context) => ProductDetails(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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