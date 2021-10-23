// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_cart_model.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  List<GetCart> favorite = [];
  String query = "arizki.nf02@gmail.com";
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
        final favorite = await ApiServices().getMusic(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.favorite = favorite;
        });
      });

  Future init() async {
    final favorite = await ApiServices().getMusic(query);

    setState(() => this.favorite = favorite);
  }

  @override
  Widget build(BuildContext context) {
    //
    Widget buildBook(GetCart music, int index, List<GetCart> listMusic) =>
        ListTile(
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
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
        title: Text("Your Favourite Music"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    final favorite = await ApiServices().getMusic(query);

                    setState(() => this.favorite = favorite);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                      itemCount: favorite.length,
                      itemBuilder: (context, index) {
                        final book = favorite[index];

                        return buildBook(book, index, favorite);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
