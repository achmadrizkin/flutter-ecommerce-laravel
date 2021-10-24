// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_products.dart';
import 'package:flutter_ecommerce_laravel/pages/product_details/product_getProduct.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class ProductBrand extends StatefulWidget {
  const ProductBrand({Key? key}) : super(key: key);

  @override
  State<ProductBrand> createState() => _ProductBrandState();
}

class _ProductBrandState extends State<ProductBrand> {
  List<GetProduct> product = [];
  String query = "Onikuma";
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
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
        final product = await ApiServices().getByProduct(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.product = product;
        });
      });

  Future init() async {
    final product = await ApiServices().getByProduct(query);

    setState(() => this.product = product);
  }

  @override
  Widget build(BuildContext context) {
    //

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: FutureBuilder<List<GetProduct>>(
        future: ApiServices().getByProduct(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height / 4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.length,
                itemBuilder: (context, index) {
                  final data = product[index];

                  return Container(
                    color: black,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductGetProductDetails(
                                    data: data,
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
                grey,
                // Medium color
                grey,
              ],
            );
          }
        },
      ),
    );
  }
}
