import 'package:demoapp/app_constants/app_constants.dart';
import 'package:demoapp/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Entry point of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Nested Scaffold Problem',
      home: MainScreen(),
    );
  }
}


/// MainScreen: Holds the parent Scaffold with Drawer & BottomNavigationBar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of child screens
  final List<Widget> _screens = [
    const HomeScreenOne(),
    const HomeScreenTwo(),
    const HomeScreenThree(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppConstants.mainScaffoldKey, // ✅ GlobalKey assigned here
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "One"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Two"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Three"),
        ],
      ),
    );
  }
}

/// Child screens with **own Scaffold** — this is the problem scenario
class HomeScreenOne extends StatelessWidget {
  const HomeScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ❌ Adding Scaffold here creates a **nested scaffold**
      // leading: SizedBox prevents default back button
      appBar: AppBar(title: const Text("Home Screen One"), leading: const SizedBox()),
      body: const Center(child: OpenDrawerWidget()),
    );
  }
}

class HomeScreenTwo extends StatelessWidget {
  const HomeScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen Two"), leading: const SizedBox()),
      body: const Center(child: OpenDrawerWidget()),
    );
  }
}

class HomeScreenThree extends StatelessWidget {
  const HomeScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen Three"), leading: const SizedBox()),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // ❌ PROBLEM: This calls the nearest Scaffold in the widget tree
            // Scaffold.of(context).openDrawer(); 
            // In this case, it would try to open the drawer of THIS nested scaffold,
            // not the MainScreen scaffold, and may fail or hide the BottomNavigationBar.

            // ✅ WORKAROUND: Using GlobalKey to access **parent Scaffold**
            AppConstants.mainScaffoldKey.currentState?.openDrawer();
          },
          child: const Text("Open Drawer"),
        ),
      ),
    );
  }
}

/// Common widget to open drawer
class OpenDrawerWidget extends StatelessWidget {
  const OpenDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ❌ PROBLEM: Calls the **immediate Scaffold** in the widget tree
        // This is why nested Scaffold prevents drawer opening properly
        // Scaffold.of(context).openDrawer();

        // ✅ WORKAROUND: Using GlobalKey to open the MainScreen's drawer
        AppConstants.mainScaffoldKey.currentState?.openDrawer();
      },
      child: const Text("Open Drawer"),
    );
  }
}
