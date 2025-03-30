import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/config/route/app_routes.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';

import 'src/config/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await LocalStorageManager.init();
  await setupDependencies();
  runApp(const MyApp());
}

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

          BlocProvider(create: (context) => getIt<CategoryBloc>())
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple),
                  useMaterial3: true,
                  appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.white,
                      centerTitle: true,
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold)),
                  scaffoldBackgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.white),
                  iconButtonTheme: const IconButtonThemeData(
                      style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll<Color>(Colors.grey),
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            Colors.white),
                      ))),
              routerConfig: AppRoutes.router,
            );
          },
        )
    );
  }
}
