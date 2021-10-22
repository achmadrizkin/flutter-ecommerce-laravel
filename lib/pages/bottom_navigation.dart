import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/pages/connection/no_internet.dart';
import 'package:flutter_ecommerce_laravel/pages/home/home.dart';
import 'package:flutter_ecommerce_laravel/pages/search/search.dart';
import 'package:flutter_ecommerce_laravel/pages/user/user.dart';
import 'package:flutter_ecommerce_laravel/provider/connectivity_provider.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

/// This is the private State class that goes with BottomNav.
class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Search(),
    User(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
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
                    child: _widgetOptions.elementAt(_selectedIndex),
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
                        icon: Icon(Icons.library_books),
                        label: 'Your Library',
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
