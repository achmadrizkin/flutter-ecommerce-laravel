import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/pages/bottom_navigation.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class InvoiceDetailsSuccess extends StatelessWidget {
  const InvoiceDetailsSuccess({Key? key, required this.paymentID}) : super(key: key);

  final String paymentID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("asset/right.png", width: 80, height: 80),

                //
                AutoSizeText(
                  "Payment successful",
                  style:
                      headingStyle.copyWith(color: Colors.green, fontSize: 22),
                ),

                AutoSizeText(
                  "Transaction id: ${paymentID}",
                  style: headingStyle2.copyWith(color: black, fontSize: 12),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Divider(
                    color: black,
                    height: 50,
                  ),
                ),

                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNav()),
                      );
                    },
                    child: AutoSizeText("Return to homepage",
                        style: subTitleTextStyle.copyWith(color: white)),
                    style: ElevatedButton.styleFrom(primary: Colors.green)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
