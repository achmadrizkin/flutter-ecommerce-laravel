// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_cart_model.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  List<GetCart> cart = [];
  String? query = "a";
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    query = Provider.of<LoginController>(context, listen: false)
        .userDetails!
        .email!;

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
        final cart = await ApiServices().getCartByUser(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.cart = cart;
        });
      });

  Future init() async {
    final cart = await ApiServices().getCartByUser(query!);

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

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Your Favourite Music",
          style: headingStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: RefreshIndicator(
                    onRefresh: () async {
                      final cart = await ApiServices().getCartByUser(query!);

                      setState(() => this.cart = cart);
                    },
                    child: FutureBuilder<List<GetCart>>(
                      future: ApiServices().getCartByUser(query!),
                      builder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              final book = cart[index];

                              return buildBook(book);
                            },
                          ),
                        );
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
