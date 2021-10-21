import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';

class EditProduct extends StatefulWidget {
  EditProduct({Key? key, required this.data}) : super(key: key);

  final Datum data;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
        title: Text("Edit Products"),
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
                  // initialize from passing widget
                  controller: nameController..text = widget.data.name,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Please input product name";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: descriptionController
                    ..text = widget.data.description,
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return "Please input product description";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Price"),
                  controller: priceController..text = widget.data.price,
                  validator: (value) {
                    if (value == null || value.length < 2 || value == 0) {
                      return "Please input product price";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Image Url"),
                  controller: imageUrlController..text = widget.data.imageUrl,
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
                            .updateProduct(
                              nameController.text,
                              descriptionController.text,
                              imageUrlController.text,
                              priceController.text,
                              widget.data.id,
                            )
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
