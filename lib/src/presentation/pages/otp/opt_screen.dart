import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/otp/widgets/otp_fields.dart';
import 'package:mera_bazaar/src/presentation/widets/loading_button.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Verify OTP"),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Mera Bazaar",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
              child: Image.asset(
            "assets/images/main_icon.png",
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          )),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "OTP Verification",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Enter the otp sent to +9112345*****",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 20,
          ),
          OtpFields(
            pinController: _controller,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
            if (state is VerifyOtpLoading) {
              return const SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator());
            }
            return LoadingButton(
                text: "Verify OTP",
                onPress: () {
                  if (_controller.text.isEmpty || _controller.text.length < 4) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter valid number"),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  context.read<AuthBloc>().add(VerifyOtpEvent(
                      number: "1234567890", otp: _controller.text));
                });
          }, listener: (context, state) {
            if (state is VerifyOtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                ),
                backgroundColor: Colors.green,
              ));

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  (route) => false);
            } else if (state is VerifyOtpError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            }
          })
        ],
      ),
    );
  }
}
