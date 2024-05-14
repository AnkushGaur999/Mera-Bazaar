import 'package:flutter/material.dart';
import 'package:mera_bazaar/ui/dashboard/dashboard_screen.dart';
import 'package:mera_bazaar/ui/otp/widgets/pin_put.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Otp",
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

          Pin_Put(),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade500,
                  fixedSize: const Size(240, 40),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              onPressed: () {
                Navigator.push(context,
                    (MaterialPageRoute(builder: (context) => const DashboardScreen())));
              },
              child: const Text(
                "Verify OTP",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
