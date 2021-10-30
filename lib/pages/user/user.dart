import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/pages/add_products/add_product.dart';
import 'package:flutter_ecommerce_laravel/pages/cart/cart_product.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/all_products.dart';
import 'package:flutter_ecommerce_laravel/pages/recent_transaction/recent_transaction.dart';
import 'package:flutter_ecommerce_laravel/pages/user/widget/user_detail.dart';
import 'package:flutter_ecommerce_laravel/pages/your_products/your_products.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetails(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProduct()),
                    );
                  },
                  child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: black, size: 24),
                          SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            "Add",
                            style: headingStyle.copyWith(
                                fontSize: 12, color: black),
                          ),
                        ],
                      )),
                ),

                //
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => YourProducts()));
                  },
                  child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.card_travel, color: black, size: 24),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: AutoSizeText(
                              "Your Products",
                              style: headingStyle.copyWith(
                                  fontSize: 5, color: black),
                            ),
                          ),
                        ],
                      )),
                ),

                //
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartProducts()),
                    );
                  },
                  child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: black, size: 24),
                          SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            "Cart",
                            style: headingStyle.copyWith(
                                fontSize: 12, color: black),
                          ),
                        ],
                      )),
                ),

                //
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecentTransaction()),
                    );
                  },
                  child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.task, color: black, size: 24),
                          SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            "Transaction",
                            style: headingStyle.copyWith(
                                fontSize: 12, color: black),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: AutoSizeText(
                "Top Product",
                style: headingStyle.copyWith(fontSize: 20),
              ),
            ),
            AllProducts(),
          ],
        ),
      ),
    );
  }
}
