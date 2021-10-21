import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/add_product.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/edit_product.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/product_details.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Barang> datum;

  @override
  void initState() {
    super.initState();
    datum = ApiServices().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce Shop"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder<Barang>(
          future: ApiServices().getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.data[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails()),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(data.imageUrl),
                        title: Text(data.name),
                        subtitle: Text(data.price),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProduct(
                                            data: data,
                                          )),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return SizedBox(
                width: 0,
              );
            }
          },
        ),
      ),
    );
  }
}
