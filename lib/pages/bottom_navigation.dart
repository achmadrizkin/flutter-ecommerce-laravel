import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/pages/connection/no_internet.dart';
import 'package:flutter_ecommerce_laravel/pages/home/home.dart';
import 'package:flutter_ecommerce_laravel/pages/search/search.dart';
import 'package:flutter_ecommerce_laravel/pages/user/user.dart';
import 'package:flutter_ecommerce_laravel/provider/connectivity_provider.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key, required this.model}) : super(key: key);

  final LoginController model;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

/// This is the private State class that goes with BottomNav.
class _BottomNavState extends State<BottomNav> {
  late LoginController models;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    models = widget.model;
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return Home(
          model: widget.model,
        );
        break;
      case 1:
        return Search();
        break;
      default:
        return User(
          model: widget.model,
        );
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline != null) {
          return model.isOnline
              ? Scaffold(
                  body: Center(
                    child: getPage(_selectedIndex),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'User',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: white,
                    unselectedItemColor: unselectedItem,
                    backgroundColor: bottomNavigation,
                    onTap: _onItemTapped,
                  ),
                )
              : NoInternetConnection();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
