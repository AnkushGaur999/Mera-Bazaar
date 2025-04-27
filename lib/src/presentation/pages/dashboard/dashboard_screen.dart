import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/src/config/di/service_locator.dart';
import 'package:mera_bazaar/src/config/localization/app_localizations.dart';
import 'package:mera_bazaar/src/config/route/app_routes.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/account/account_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/cart/cart_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/category/category_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    if (index == 2 || index == 3) {
      if (getIt<LocalStorageManager>().token.isEmpty) {
        context.pushNamed(AppRoutes.login);
        return;
      }
    }

    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: AppLocalizations.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category_sharp),
                label: AppLocalizations.of(context).category,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart),
                label: AppLocalizations.of(context).cart,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle),
                label: AppLocalizations.of(context).account,
              ),
            ],
            currentIndex: _selectedIndex,
            //New
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue.shade900,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
