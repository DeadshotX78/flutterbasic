// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBorderRadius: 24,
        tabBackgroundColor: Colors.grey.shade300,
        mainAxisAlignment: MainAxisAlignment.center,
        color: Colors.grey.shade400,
        tabs: const [
          GButton(
            iconActiveColor: Colors.brown,
            icon: Icons.home_rounded,
            text: 'Home',
          ),
          GButton(
            iconActiveColor: Colors.brown,
            icon: Icons.shopping_cart_rounded,
            text: 'Cart',
          ),
          GButton(
            iconActiveColor: Colors.brown,
            icon: Icons.person_rounded,
            text: 'User',
          ),
        ],
      ),
    );
  }
}
