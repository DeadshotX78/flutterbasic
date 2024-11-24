import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          DrawerHeader(
            child: Image.asset(
              'lib/assets/images/splash1.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Divider(
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: ListTile(
              title: Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Icon(Icons.settings),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: ListTile(
              title: Text(
                'About',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Icon(Icons.info_rounded),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Icon(Icons.logout_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
