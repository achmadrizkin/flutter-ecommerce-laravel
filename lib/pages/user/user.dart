import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText("Achmad Rizki Nur F",
                          style: headingStyle.copyWith(
                            color: black,
                          )),
                      AutoSizeText(
                        "arizki.nf02@gmail.com",
                        style: subTitleTextStyle.copyWith(color: grey),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
