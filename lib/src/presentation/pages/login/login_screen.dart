import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/core/extensions/context_extensions.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/pages/login/widget/mobile_text_field.dart';
import 'package:mera_bazaar/src/presentation/pages/otp/opt_screen.dart';
import 'package:mera_bazaar/src/presentation/widets/loading_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Mera Bazaar",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
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
            "Enter Your Mobile Number",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "We will send you 4 digit code verification code",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 10,
          ),
          MobileTextField(
            controller: _controller,
            onChange: (String? value) {
              if(value?.length == 10){
                context.unFocus();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
            if (state is SendOtpLoading) {
              return const SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator());
            }

            return LoadingButton(
                text: "SEND OTP",
                onPress: () {
                  if (_controller.text.isEmpty ||
                      _controller.text.length < 10) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter valid mobile number"),
                    ));
                  } else {
                    context
                        .read<AuthBloc>()
                        .add(SendOtpEvent(number: _controller.text));
                  }
                });
          }, listener: (context, state) {
            if (state is SendOtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                ),
                backgroundColor: Colors.green,
              ));

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OtpScreen()));
            } else if (state is SendOtpError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                ),
                backgroundColor: Colors.red,
              ));
            }
          })
        ],
      ),
    );
  }
}
