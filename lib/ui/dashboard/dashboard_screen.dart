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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue.shade900,
        ),
        body: PageView(
          controller: _pageController,
          children: _pages,
        ),
        bottomNavigationBar: BottomAppBar(
          height: 90,
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
              selectedLabelStyle: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_sharp),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notification_add),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Account',
                ),
              ],
              currentIndex: _selectedIndex,
              //New
              onTap: _onItemTapped,
              selectedItemColor: Colors.blue.shade900,
              unselectedItemColor: Colors.grey,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
