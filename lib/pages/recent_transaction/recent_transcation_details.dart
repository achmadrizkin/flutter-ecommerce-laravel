import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/get_invoice.dart';
import 'package:flutter_ecommerce_laravel/pages/recent_transaction/recent_transaction.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({Key? key, required this.data}) : super(key: key);

  final GetInvoice data;

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
              onPressed: () {
                //
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Do you really want to delete ?"),
                          actions: [
                            FlatButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text("No")),
                            FlatButton(
                                onPressed: () {
                                  ApiServices()
                                      .deleteProduct(int.parse(data.id))
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RecentTransaction(),
                                      ),
                                    );

                                    Fluttertoast.showToast(
                                        msg: "Delete data success",
                                        backgroundColor: white,
                                        textColor: black,
                                        toastLength: Toast.LENGTH_SHORT);
                                  });
                                },
                                child: Text("Yes"))
                          ],
                        ));
              },
              icon: Icon(Icons.delete))
        ],
        title: Text(
          "Transaction details",
          style: headingStyle,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: AutoSizeText(
                      data.name,
                      style: headingStyle.copyWith(color: black, fontSize: 22),
                    )),
                    Center(
                        child: AutoSizeText(
                      "\$ ${data.price}",
                      style: subTitleTextStyle.copyWith(
                          color: black, fontSize: 16),
                    )),

                    SizedBox(height: 10),

                    //
                    AutoSizeText(
                      "Date: ${data.createdAt}",
                      style: subTitleTextStyle.copyWith(color: black),
                    ),

                    AutoSizeText(
                      "Shop: ${data.nameShop}",
                      style: subTitleTextStyle.copyWith(color: black),
                    ),

                     AutoSizeText(
                      "Delivery details: ${data.deliveryDetails}",
                      style: subTitleTextStyle.copyWith(color: black),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
