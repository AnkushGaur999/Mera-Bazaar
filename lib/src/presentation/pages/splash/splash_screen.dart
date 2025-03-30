import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/src/config/route/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToDashboardPage();
  }

  Future<void> _goToDashboardPage() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.goNamed(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/images/main_icon.png",
            width: 180,
            height: 180,
            fit: BoxFit.contain,
          )),
          const Text(
            "Mera Bazaar",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 120.0,
          ),
          const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              )),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
