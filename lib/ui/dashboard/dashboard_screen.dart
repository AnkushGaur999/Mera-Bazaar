import 'package:flutter/material.dart';
import 'package:mera_bazaar/ui/dashboard/account/account_screen.dart';
import 'package:mera_bazaar/ui/dashboard/category/category_screen.dart';
import 'package:mera_bazaar/ui/dashboard/home/home_screen.dart';
import 'package:mera_bazaar/ui/dashboard/notification/notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  final List<Widget> _pages = const [
    HomeScreen(),
    CategoryScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
        body: PageView(
          controller: _pageController,
          children: _pages,
        ),
        bottomNavigationBar: BottomAppBar(
          height: 100,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
           backgroundColor: Colors.white,
           //ß   backgroundColor: Colors.blue,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: 'Calls',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera),
                  label: 'Camera',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chats',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chats',
                ),
              ],
              currentIndex: _selectedIndex,
              //New
              onTap: _onItemTapped,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
            ),
          ),
        ));
  }
}
