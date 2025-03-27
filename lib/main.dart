import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/data/repositories/authentication/authentication_repository_impl.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source_impl.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/verify_otp_use_case.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/pages/splash/splash_screen.dart';
import 'package:path/path.dart';

import 'src/config/di/service_locator.dart';
import 'src/domain/use_cases/auth/send_otp_use_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue.shade900,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            scaffoldBackgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
            iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
              iconColor: WidgetStatePropertyAll<Color>(Colors.white),
            ))),
        home: const SplashScreen(),
      ),
    );
  }
}
