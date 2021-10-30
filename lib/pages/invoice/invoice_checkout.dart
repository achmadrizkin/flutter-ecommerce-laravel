import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/pages/invoice/invoice_details/invoice_success_details.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/env.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key, required this.data}) : super(key: key);

  final Datum data;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late Razorpay razorpay;

  double totalPrice = 5;
  int totalProduct = 1;
  double tax = 0.1;
  double totalPriceAndTaxAndDelivery = 0.0;

  String? _dropDownValue;

  int deliveryPrice = 0;

  @override
  void initState() {
    super.initState();

    //
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  //
  void openCheckout() {
    var options = {
      "key": KEY_ID_RAZORAPP,
      "amount": totalPriceAndTaxAndDelivery.round(),
      "name": widget.data.name,
      "description": widget.data.description,
      "prefill": {
        "contact": "2323232323",
        "email": Provider.of<LoginController>(context, listen: false)
            .userDetails!
            .email
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Pament success");

    //
    ApiServices()
        .saveInvoice(
            widget.data.name,
            Provider.of<LoginController>(context, listen: false)
                .userDetails!
                .displayName!,
            Provider.of<LoginController>(context, listen: false)
                .userDetails!
                .email!,
            widget.data.description,
            widget.data.imageUrl,
            totalPriceAndTaxAndDelivery.toString(),
            widget.data.userName,
            widget.data.userEmail,
            _dropDownValue!,
            totalProduct.toString())
        .then((value) {
      Fluttertoast.showToast(
          msg: "Payment Success",
          backgroundColor: white,
          textColor: black,
          toastLength: Toast.LENGTH_SHORT);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvoiceDetailsSuccess(
            paymentID: response.paymentId!,
          ),
        ),
      );
    });

    //
  }

  void handlerErrorFailure(PaymentFailureResponse respons) {
    print("Pament error");

    //
    Fluttertoast.showToast(
        msg: "ERROR Transaction",
        backgroundColor: white,
        textColor: black,
        toastLength: Toast.LENGTH_SHORT);

    //
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      totalPrice = double.parse(widget.data.price) * totalProduct;
    });

    //
    if (_dropDownValue == 'Instant (3 Hours)')
      setState(() {
        deliveryPrice = 100;
        totalPriceAndTaxAndDelivery =
            (totalPrice + (totalPrice * tax)) + deliveryPrice;
      });
    else if (_dropDownValue == 'Same day (6 - 8 Hours)')
      setState(() {
        deliveryPrice = 50;
        totalPriceAndTaxAndDelivery =
            (totalPrice + (totalPrice * tax)) + deliveryPrice;
      });
    else if (_dropDownValue == 'Next Day (1 Day)')
      setState(() {
        deliveryPrice = 30;
        totalPriceAndTaxAndDelivery =
            (totalPrice + (totalPrice * tax)) + deliveryPrice;
      });
    else if (_dropDownValue == 'Reguler (2-4 Day)')
      setState(() {
        deliveryPrice = 5;
        totalPriceAndTaxAndDelivery =
            (totalPrice + (totalPrice * tax)) + deliveryPrice;
      });
    else if (_dropDownValue == 'Economy (1-2 Day)')
      setState(() {
        deliveryPrice = 15;
        totalPriceAndTaxAndDelivery =
            (totalPrice + (totalPrice * tax)) + deliveryPrice;
      });

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Checkout", style: headingStyle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              AutoSizeText("Product you bought",
                  style: headingStyle.copyWith(fontSize: 18, color: white)),
              AutoSizeText("Store: ${widget.data.userName}",
                  style: subTitleTextStyle.copyWith(fontSize: 14, color: grey)),

              //
              SizedBox(height: 10),

              //
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(widget.data.imageUrl,
                                width: 80, height: 80),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(widget.data.name,
                                    style: headingStyle.copyWith(
                                        fontSize: 18, color: black)),
                                AutoSizeText("Price: \$ ${totalPrice}",
                                    style: subTitleTextStyle.copyWith(
                                        fontSize: 14, color: grey)),

                                //
                                Row(
                                  children: [
                                    totalProduct <= 0
                                        ? SizedBox(height: 0)
                                        : IconButton(
                                            icon: new Icon(Icons.remove),
                                            onPressed: () {
                                              if (totalProduct == 1) {
                                                Navigator.pop(context);
                                              } else {
                                                setState(() {
                                                  totalProduct--;
                                                });
                                              }
                                            }),
                                    AutoSizeText("${totalProduct}",
                                        style: headingStyle.copyWith(
                                            fontSize: 14, color: black)),
                                    IconButton(
                                        icon: new Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            totalProduct++;
                                          });
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //
              SizedBox(height: 20),
              AutoSizeText("Delivery details",
                  style: headingStyle.copyWith(fontSize: 18, color: white)),

              //
              SizedBox(height: 10),

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //
                        DropdownButton(
                          hint: _dropDownValue == null
                              ? Text(
                                  "Please select delivery",
                                  style: headingStyle2.copyWith(color: black),
                                )
                              : Text(
                                  _dropDownValue!,
                                  style: headingStyle2.copyWith(color: black),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.blue),
                          items: [
                            'Instant (3 Hours)',
                            'Same day (6 - 8 Hours)',
                            'Next Day (1 Day)',
                            'Reguler (2-4 Day)',
                            'Economy (1-2 Day)'
                          ].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val,
                                    style:
                                        headingStyle2.copyWith(color: black)),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _dropDownValue = val.toString();
                                print(_dropDownValue);

                                //
                                print(totalPriceAndTaxAndDelivery);
                              },
                            );
                          },
                        ),

                        //
                        Align(
                            alignment: Alignment.bottomRight,
                            child: AutoSizeText(
                              "Delivery price: \$ ${deliveryPrice}",
                              style: subTitleTextStyle.copyWith(color: grey),
                            )),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: AutoSizeText(
                              "Product price: \$ ${totalPrice}",
                              style: subTitleTextStyle.copyWith(color: grey),
                            )),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: AutoSizeText(
                              "Tax price: 10%",
                              style: subTitleTextStyle.copyWith(color: grey),
                            )),

                        //
                        Align(
                            alignment: Alignment.bottomRight,
                            child: AutoSizeText(
                              "Total price: \$ " +
                                  totalPriceAndTaxAndDelivery
                                      .toStringAsFixed(1),
                              style: headingStyle.copyWith(color: black),
                            )),
                      ],
                    ),
                  ),
                ),
              ),

              //
              SizedBox(height: 10),
              totalPriceAndTaxAndDelivery == 0
                  ? Center(
                      child: AutoSizeText("Please pick delivery",
                          style: headingStyle.copyWith(
                              fontSize: 18, color: white)),
                    )
                  : AutoSizeText("Pay using:",
                      style: headingStyle.copyWith(fontSize: 18, color: white)),

              //
              SizedBox(height: 10),
              totalPriceAndTaxAndDelivery == 0
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        child: ElevatedButton(
                          onPressed: () {
                            openCheckout();
                          },
                          child: AutoSizeText("Pay using Razorpay",
                              style: headingStyle2.copyWith(color: black)),
                          style: ElevatedButton.styleFrom(primary: white),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
