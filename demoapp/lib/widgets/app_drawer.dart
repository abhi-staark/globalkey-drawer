import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(child: Text("User Profile")),
          ListTile(title: Text("Home")),
          ListTile(title: Text("Insights")),
          ListTile(title: Text("Dashboard")),
        ],
      ),
    );
  }
}
