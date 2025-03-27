import 'package:flutter/material.dart';
import 'package:mera_bazaar/resources/app_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Account Page",
          ),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Center(
          child: Hero(
            tag: "hero-tag",
            child: Container(
              height: 280,
              width: 280,
              color: Colors.green,
            ),
          ),
        ));
  }
}
