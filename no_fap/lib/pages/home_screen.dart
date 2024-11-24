import 'package:flutter/material.dart';
import 'package:no_fap/components/bottom_nav.dart';
import 'package:no_fap/constants.dart';
import 'package:no_fap/pages/cart_screen.dart';
import 'package:no_fap/pages/shop_screen.dart';
import 'package:no_fap/pages/user_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;
  void navigateBottomNavBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  //pages
  final List<Widget> _pages = [
    const ShopPage(),
    const CartPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNav(
        onTabChange: (index) => navigateBottomNavBar(index),
      ),
      body: _pages[_selectedindex],
    );
  }
}
