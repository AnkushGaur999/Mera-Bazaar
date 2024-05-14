import 'package:flutter/material.dart';

class NoNumberText extends StatelessWidget {
  const NoNumberText({super.key});


  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: const Text(
            "*Please provide mobile no.",
            style: TextStyle(color: Colors.red),
          ),
        ));
  }
}
