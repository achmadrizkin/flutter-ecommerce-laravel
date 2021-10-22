import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("asset/error.png")),
          AutoSizeText(
            "No Connection",
            style: headingStyle.copyWith(
                fontSize: 24, color: white, fontWeight: FontWeight.bold),
          ),
          AutoSizeText(
            "Check your connection or try again",
            style: headingStyle.copyWith(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}