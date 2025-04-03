import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/config/route/app_routes.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/theme/theme_bloc.dart';
import 'src/config/di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
        BlocProvider(create: (context) => getIt<AuthBloc>()),

        BlocProvider(create: (context) => getIt<CategoryBloc>()),

        BlocProvider(create: (context) => getIt<ThemeBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeLoad>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Flutter Demo',
                theme: state.themeData,
                routerConfig: AppRoutes.router,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale("en"),
              );
            },
          );
        },
      ),
    );
  }
}
