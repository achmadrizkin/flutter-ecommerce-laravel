import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/pages/splash_screen.dart';
import 'package:flutter_ecommerce_laravel/provider/connectivity_provider.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: SplashScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
          child: SplashScreen(),
        ),
      ],
      child: MaterialApp(
        title: "Flutter E-Commerce",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
