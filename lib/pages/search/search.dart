import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_products.dart';
import 'package:flutter_ecommerce_laravel/pages/product_details/product_getProduct.dart';
import 'package:flutter_ecommerce_laravel/pages/search/widget/search_widget.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<GetProduct> product = [];
  String query = '';
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

  Future init() async {
    final product = await ApiServices().searchProduct(query);

    setState(() => this.product = product);
  }

  Future searchBook(String query) async => debounce(() async {
        final product = await ApiServices().searchProduct(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.product = product;
        });
      });

  @override
  Widget build(BuildContext context) {
    Widget buildSearch() => SearchWidget(
          text: query,
          hintText: 'Product or Shop',
          onChanged: searchBook,
        );

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSearch(),

              //
              SizedBox(height: 10),
              query.length == 0
                  ? SizedBox(
                      height: 0,
                    )
                  : FutureBuilder<List<GetProduct>>(
                      future: ApiServices().searchProduct(query),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            height: MediaQuery.of(context).size.height / 2,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: product.length,
                              itemBuilder: (context, index) {
                                final book = product[index];

                                return Container(
                                  color: black,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductGetProductDetails(
                                                  data: book,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          40,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: black,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                book.imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          //
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(book.name,
                                                    style:
                                                        headingStyle2.copyWith(
                                                            color: Colors.white,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                                AutoSizeText("\$ ${book.price}",
                                                    style: subTitleTextStyle
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: 5,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
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
                          ),
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
