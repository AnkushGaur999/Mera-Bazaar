import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:mera_bazaar/ui/dashboard/dashboard_screen.dart';
import 'package:mera_bazaar/ui/otp/widgets/pin_put.dart';
import 'package:mera_bazaar/ui/widets/loading_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "OTP",
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
          const Pin_Put(),
          const SizedBox(
            height: 20,
          ),
          LoadingButton(text: "Verify OTP", onPress: () => _delayFun(context))
        ],
      ),
    );
  }

  void _delayFun(context) async {
    await Future.delayed(const Duration(seconds: 5));

    final materialBanner = MaterialBanner(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: 'Welcome!',
        message: 'Hey John. We please you to see here.',
        contentType: ContentType.success,
        // to configure for material banner
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );
    final snackBar = SnackBar(
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
      content: const Text(
        "Mobile number verified",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.shade900,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
    Navigator.push(context,
        (MaterialPageRoute(builder: (context) => const DashboardScreen())));
  }
}
