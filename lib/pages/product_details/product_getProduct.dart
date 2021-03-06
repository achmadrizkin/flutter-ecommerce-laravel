import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_products.dart';
import 'package:flutter_ecommerce_laravel/pages/chat/chat_page.dart';
import 'package:flutter_ecommerce_laravel/pages/invoice/invoice_checkout2.dart';
import 'package:flutter_ecommerce_laravel/pages/user_shop/user_shop2.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductGetProductDetails extends StatelessWidget {
  const ProductGetProductDetails({Key? key, required this.data})
      : super(key: key);

  final GetProduct data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(data.name, style: headingStyle),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    data.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(data.name,
                      style: headingStyle.copyWith(fontSize: 24)),
                  AutoSizeText("\$ ${data.price}",
                      style: headingStyle2.copyWith(fontSize: 18)),
                  AutoSizeText(
                    data.description,
                    style: subTitleTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15,
            ),

            //
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.person),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(data.userName,
                            style: headingStyle.copyWith(
                                color: black, fontSize: 16)),
                        AutoSizeText(
                          data.userEmail,
                          style: subTitleTextStyle.copyWith(
                              color: Colors.black45, fontSize: 12),
                        ),
                      ],
                    ),

                    //
                    OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserShop2(
                                      data: data,
                                    )),
                          );
                        },
                        child: AutoSizeText(
                          "Visit Store",
                          style: headingStyle.copyWith(color: Colors.red),
                        ),
                        borderSide: BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0))),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 4 - 10,
                    child: ElevatedButton(
                      onPressed: () {
                        if (data.userEmail.contains(
                            Provider.of<LoginController>(context, listen: false)
                                .userDetails!
                                .email!)) {
                          Fluttertoast.showToast(
                              msg: "You cannot chat your own",
                              backgroundColor: white,
                              textColor: black,
                              toastLength: Toast.LENGTH_SHORT);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      emailTo: data.userEmail,
                                      nameTo: data.userName,
                                    )),
                          );
                        }
                      },
                      child: Icon(Icons.chat),
                      style: ElevatedButton.styleFrom(
                        primary: green, // background
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 4 - 10,
                    child: ElevatedButton(
                      onPressed: () {
                        if (data.userEmail.contains(
                            Provider.of<LoginController>(context, listen: false)
                                .userDetails!
                                .email!)) {
                          Fluttertoast.showToast(
                              msg: "You cannot buy your own product",
                              backgroundColor: white,
                              textColor: black,
                              toastLength: Toast.LENGTH_SHORT);
                        } else {
                          ApiServices()
                              .saveCart(
                                  data.name,
                                  Provider.of<LoginController>(context,
                                          listen: false)
                                      .userDetails!
                                      .displayName!,
                                  Provider.of<LoginController>(context,
                                          listen: false)
                                      .userDetails!
                                      .email!,
                                  data.description,
                                  data.imageUrl,
                                  data.price,
                                  data.userName,
                                  data.userEmail)
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: "Add Cart Success",
                                backgroundColor: white,
                                textColor: black,
                                toastLength: Toast.LENGTH_SHORT);
                          });
                        }
                      },
                      child: Icon(Icons.shopping_cart),
                      style: ElevatedButton.styleFrom(
                        primary: green, // background
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    child: ElevatedButton(
                      onPressed: () {
                        if (data.userEmail.contains(
                            Provider.of<LoginController>(context, listen: false)
                                .userDetails!
                                .email!)) {
                          Fluttertoast.showToast(
                              msg: "You cannot buy your own product",
                              backgroundColor: white,
                              textColor: black,
                              toastLength: Toast.LENGTH_SHORT);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOut2(
                                      data: data,
                                    )),
                          );
                        }
                      },
                      child: Text(
                        "Buy Right Now",
                        style: subTitleTextStyle.copyWith(
                            color: white, fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
