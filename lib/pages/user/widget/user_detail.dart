import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.models,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final LoginController models;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.network(models.userDetails!.photoURL ?? "",
                fit: BoxFit.cover, width: 80, height: 80),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(models.userDetails!.displayName ?? "",
                  style: headingStyle.copyWith(
                    color: black,
                  )),
              AutoSizeText(
                models.userDetails!.email ?? "",
                style: subTitleTextStyle.copyWith(color: grey),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<LoginController>(context, listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }
}
