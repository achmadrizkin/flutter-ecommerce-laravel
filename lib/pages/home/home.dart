import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Barang> datum;
  bool? _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    datum = ApiServices().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _loading! ? Text("Loading") : Text("NOT LOADING"),
      ),
      body: FutureBuilder<Barang>(
        future: ApiServices().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.data[index];

                  return ListTile(
                    title: Text(data.name),
                    subtitle: Text(data.price),
                  );
                });
          } else {
            return SizedBox(width: 0,);
          }
        },
      ),
    );
  }
}
