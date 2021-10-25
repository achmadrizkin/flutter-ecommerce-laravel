import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/pages/bottom_navigation.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Consumer<LoginController>(
          builder: (context, models, child) {
            // if we already logged in
            if (models.userDetails != null) {
              return BottomNav(
                model: models,
              );
            } else {
              return loginController(context);
            }
          },
        ),
      ),
    );
  }

  loginController(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(child: Image.asset("asset/logo.png")),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hey there\nWelcome back',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: white),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login to your account to continue',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.normal, color: white),
            ),
          ),
          Spacer(),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
              onPressed: () {
                final provider =
                    Provider.of<LoginController>(context, listen: false);
                provider.googleLogin();
              },
              label: Text('Sign up with Google')),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: 'Already have a account? ',
                style: TextStyle(color: white),
                children: [
                  TextSpan(
                    text: 'Log in',
                    style: TextStyle(
                        decoration: TextDecoration.underline, color: white),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
