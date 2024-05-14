import 'package:flutter/material.dart';
import 'package:mera_bazaar/ui/login/widget/mobile_text_field.dart';
import 'package:mera_bazaar/ui/otp/opt_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
              child: Image.asset(
            "assets/images/main_icon.png",
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          )),
          const SizedBox(
            height: 30,
          ),
          MobileTextField(
            onSave: (String? value) {
              print("onSave $value");
            },
            onChange: (String? value) {
              print("onChange $value");
            },
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade500,
                  fixedSize: const Size(240, 40),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              onPressed: () {
                Navigator.push(context,
                    (MaterialPageRoute(builder: (context) => const OtpScreen())));
              },
              child: const Text(
                "Send OTP",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
