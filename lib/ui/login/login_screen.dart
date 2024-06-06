import 'package:flutter/material.dart';
import 'package:mera_bazaar/ui/login/widget/mobile_text_field.dart';
import 'package:mera_bazaar/ui/otp/opt_screen.dart';
import 'package:mera_bazaar/ui/widets/loading_button.dart';

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
            onChange: (String? value) {
              print("onChange $value");
            },
          ),
          LoadingButton(text: "Send OTP", onPress: () => _funDelay(context))
        ],
      ),
    );
  }

  void _funDelay(context) async {
    await Future.delayed(const Duration(seconds: 5));
    final snackBar = SnackBar(
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
      content: const Text(
        "OTP successfully send to your mobile number",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.shade900,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.push(
        context, (MaterialPageRoute(builder: (context) => const OtpScreen())));
  }
}
