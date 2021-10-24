import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key, required this.model}) : super(key: key);

  final LoginController model;

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
      appBar: AppBar(
        title: Text("Add Products"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Please input product name";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return "Please input product description";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Price"),
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.length < 2 || value == 0) {
                      return "Please input product price";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Image Url"),
                  controller: imageUrlController,
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return "Please input product image";
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ApiServices()
                            .saveProduct(
                                nameController.text,
                                widget.model,
                                descriptionController.text,
                                imageUrlController.text,
                                priceController.text)
                            .then((value) => Navigator.pop(context));
                      }
                    },
                    child: Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
