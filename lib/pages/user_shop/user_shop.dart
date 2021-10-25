import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/pages/user_shop/widget/product_recomendation.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class UserShop extends StatefulWidget {
  const UserShop({Key? key, required this.data}) : super(key: key);

  final Datum data;

  @override
  State<UserShop> createState() => _UserShopState();
}

class _UserShopState extends State<UserShop> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight / 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(40.0),
                    bottomRight: const Radius.circular(40.0),
                  ),
                  color: white),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 80,
                    ),

                    //
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                            widget.data.userName,
                            style: headingStyle.copyWith(
                              color: black,
                            )),
                        AutoSizeText(
                          widget.data.userEmail,
                          style: subTitleTextStyle.copyWith(color: grey),
                        ),
                      ],
                    ),

                    //
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlineButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserShop(
                                          data: widget.data,
                                        )),
                              );
                            },
                            child: AutoSizeText(
                              "Follow",
                              style: headingStyle.copyWith(color: black),
                            ),
                            borderSide: BorderSide(color: black),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0))),

                        //
                        OutlineButton(
                            onPressed: () {
                              
                            },
                            child: AutoSizeText(
                              "Chat",
                              style: headingStyle.copyWith(color: black),
                            ),
                            borderSide: BorderSide(color: black),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "All Products",
                    style: headingStyle.copyWith(fontSize: 20),
                  ),

                  //
                  ProductRecomendation(data: widget.data,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
