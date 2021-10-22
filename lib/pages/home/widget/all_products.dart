import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/model/products_model.dart';
import 'package:flutter_ecommerce_laravel/pages/home/widget/product_details.dart';
import 'package:flutter_ecommerce_laravel/service/api_services.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late Future<Barang> datum;

  @override
  void initState() {
    super.initState();
    datum = ApiServices().getData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: blue,
      backgroundColor: white,
      onRefresh: () async {
        setState(() {
          datum = ApiServices().getData();
        });
      },
      child: FutureBuilder<Barang>(
        future: ApiServices().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height / 4,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.data[index];

                    return Container(
                      color: black,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(data: data,)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          height: MediaQuery.of(context).size.height / 2 - 10,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: black,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    data.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AutoSizeText(data.name,
                                  style: headingStyle2.copyWith(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis)),
                              AutoSizeText("\$ ${data.price}",
                                  style: subTitleTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: 5,
                                      overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return SizedBox(
              width: 0,
            );
          }
        },
      ),
    );
  }
}
