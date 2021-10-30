import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: AutoSizeText(
          "Add Products",
          style: headingStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusColor: white,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Name",
                          labelStyle: headingStyle2.copyWith(color: black)),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return "Please input product name";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusColor: white,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Description",
                          labelStyle: headingStyle2.copyWith(color: black)),
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.length < 10) {
                          return "Please input product description";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusColor: white,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Price",
                          labelStyle: headingStyle2.copyWith(color: black)),
                      controller: priceController,
                      validator: (value) {
                        if (value == null || value.length < 2 || value == 0) {
                          return "Please input product price";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusColor: white,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Image Url",
                          labelStyle: headingStyle2.copyWith(color: black)),
                      controller: imageUrlController,
                      validator: (value) {
                        if (value == null || value.length < 5) {
                          return "Please input product image";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: white),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ApiServices()
                            .saveProduct(
                                nameController.text,
                                Provider.of<LoginController>(context,
                                        listen: false)
                                    .userDetails!
                                    .displayName!,
                                Provider.of<LoginController>(context,
                                        listen: false)
                                    .userDetails!
                                    .email!,
                                descriptionController.text,
                                imageUrlController.text,
                                priceController.text)
                            .then((value) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Post data success",
                              backgroundColor: white,
                              textColor: black,
                              toastLength: Toast.LENGTH_SHORT);
                        });
                      }
                    },
                    child: Text(
                      "Post Product",
                      style: headingStyle.copyWith(color: black),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
