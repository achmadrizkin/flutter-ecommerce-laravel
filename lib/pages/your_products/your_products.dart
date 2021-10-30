import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_products.dart';
import 'package:flutter_ecommerce_laravel/pages/product_details/product_getProduct.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:provider/provider.dart';

class YourProducts extends StatefulWidget {
  const YourProducts({Key? key}) : super(key: key);

  @override
  State<YourProducts> createState() => _YourProductsState();
}

class _YourProductsState extends State<YourProducts> {
  List<GetProduct> product = [];
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
    final product = await ApiServices().getUserProduct(
        Provider.of<LoginController>(context, listen: false)
            .userDetails!
            .email!);

    setState(() => this.product = product);
  }

  Future searchBook(String query) async => debounce(() async {
        final product = await ApiServices().getUserProduct(
            Provider.of<LoginController>(context, listen: false)
                .userDetails!
                .email!);

        if (!mounted) return;

        setState(() {
          this.product = product;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: AutoSizeText(
          "Your Products",
          style: headingStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final product = await ApiServices().getUserProduct(
                Provider.of<LoginController>(context, listen: false)
                    .userDetails!
                    .email!);

            setState(() => this.product = product);
          },
          child: FutureBuilder<List<GetProduct>>(
              future: ApiServices().getUserProduct(
                  Provider.of<LoginController>(context, listen: false)
                      .userDetails!
                      .email!),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height - 100,
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
                              width: MediaQuery.of(context).size.width / 2 - 40,
                              height: MediaQuery.of(context).size.height / 2,
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
                                            style: headingStyle2.copyWith(
                                                color: Colors.white,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        AutoSizeText("\$ ${book.price}",
                                            style: subTitleTextStyle.copyWith(
                                                color: Colors.grey,
                                                fontSize: 5,
                                                overflow:
                                                    TextOverflow.ellipsis)),
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
        ),
      ),
    );
  }
}
