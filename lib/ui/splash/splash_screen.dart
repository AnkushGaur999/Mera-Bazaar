import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mera_bazaar/ui/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _goToLoginPage(context);
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

  void _goToLoginPage(context) {
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }
}
