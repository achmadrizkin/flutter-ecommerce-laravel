import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/pages/cart/cart_product.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/add_product.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/all_products.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/flashdisk_product.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/product_brand.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text("E-Commerce Shop", style: headingStyle,),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartProducts()),
                );
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  "All Product",
                  style: headingStyle.copyWith(fontSize: 18),
                ),
                AllProducts(),
        
                //
                AutoSizeText(
                  "Flashdisk Product",
                  style: headingStyle.copyWith(fontSize: 18),
                ),
                GetProductByName(),
        
                //
                AutoSizeText(
                  "Onikuma Brand",
                  style: headingStyle.copyWith(fontSize: 18),
                ),
                ProductBrand(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
