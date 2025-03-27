import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToLoginPage();
  }

  void _goToLoginPage() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
