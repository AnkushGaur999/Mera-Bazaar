import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/config/generated/assets.gen.dart';
import 'package:mera_bazaar/src/presentation/pages/login/widget/login_text_field.dart';
import 'package:mera_bazaar/src/presentation/widets/loading_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 100.h),

            Center(
              child: Image.asset(
                Assets.icons.appIcon.path,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 40),

            const Text(
              "Enter Your Mobile Number",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "We will send you 6 digit code \nverification code",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),
            LoginTextField(
              controller: _numberController,
              label: "Enter Mobile Number",
              maxLength: 10,
            ),

            const SizedBox(height: 10),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is SendOtpLoading) {
                  return const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  );
                }

                return LoadingButton(
                  text: "SEND OTP",
                  onPress: () async {
                    context.read<AuthBloc>().add(
                      SendOtpEvent(number: _numberController.text),
                    );
                  },
                );
              },
              listener: (context, state) {
                if (state is SendOtpSuccess) {
                  final data = {
                    "number": _numberController.text,
                    "verificationId": state.verificationId,
                  };

                  context.pushNamed(AppRoutes.otp, extra: data);
                } else if (state is SendOtpError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),

            SizedBox(height: 10.h),

            Text(
              "OR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10.h),

            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () {
                  // context.pushNamed(AppRoutes.otp);
                  ////_signInWithGoogle();
                },
                child: Image.asset(Assets.icons.googleIcon.path),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // GOOGLE SIGN IN
  Future<void> _signInWithGoogle() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider.addScope(
          'https://www.googleapis.com/auth/contacts.readonly',
        );

        await auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn.instance
            .authenticate();

        final GoogleSignInAuthentication googleAuth = googleUser.authentication;

        if (googleAuth.idToken != null && googleAuth.idToken != null) {

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.idToken,
            idToken: googleAuth.idToken,
          );
          final userCredential = await auth.signInWithCredential(credential);

          debugPrint("User: ${userCredential.user}");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? e.code)));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}
