import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/src/config/generated/assets.gen.dart';
import 'package:mera_bazaar/src/config/route/app_routes.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/widets/loading_button.dart';

import 'widgets/otp_fields.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  final String verificationId;

  const OtpScreen({
    super.key,
    required this.number,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),

          const Text(
            "Mera Bazaar",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Assets.icons.appIcon.image(
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 20),
          const Text(
            "OTP Verification",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Enter the otp sent to +91${widget.number.replaceRange(5, 10, "*****")}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          OtpFields(pinController: _controller),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is VerifyOtpLoading) {
                return const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                );
              }
              return LoadingButton(
                text: "Verify OTP",
                onPress: () {
                  if (_controller.text.isEmpty || _controller.text.length < 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter valid number"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  context.read<AuthBloc>().add(
                    VerifyOtpEvent(
                      number: widget.number,
                      verificationId: widget.verificationId,
                      otp: _controller.text,
                    ),
                  );
                },
              );
            },
            listener: (context, state) {
              if (state is VerifyOtpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );

                context.goNamed(AppRoutes.dashboard);
              } else if (state is VerifyOtpError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
