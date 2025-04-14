/// Mera Bazaar - A Flutter-based e-commerce application
///
/// This file contains the main entry point of the application and the root widget.
/// It initializes Firebase, sets up dependencies, and configures the app's theme and routing.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mera_bazaar/src/config/services/notification_service.dart';
import 'package:mera_bazaar/src/presentation/bloc/order/order_bloc.dart';
import 'main_export.dart';

/// The main entry point of the application.
///
/// This function:
/// 1. Initializes Flutter bindings
/// 2. Sets up Firebase services
/// 3. Configures analytics
/// 4. Initializes local storage
/// 5. Sets up dependency injection
/// 6. Configures notifications
/// 7. Sets preferred orientations
/// 8. Runs the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  await LocalStorageManager.init();
  await setupDependencies();
  await NotificationService.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

/// The root widget of the application.
///
/// This widget:
/// 1. Provides BLoC providers for state management
/// 2. Configures responsive design using ScreenUtilInit
/// 3. Sets up the MaterialApp with routing and theming
/// 4. Configures localization
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Authentication state management
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        // Category management
        BlocProvider(create: (context) => getIt<CategoryBloc>()),
        // Theme management
        BlocProvider(create: (context) => getIt<ThemeBloc>()),
        // Home screen state management
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        // Product management
        BlocProvider(create: (context) => getIt<ProductBloc>()),
        // Shopping cart management
        BlocProvider(create: (context) => getIt<CartBloc>()),
        // Order management
        BlocProvider(create: (context)=> getIt<OrderBloc>()),
      ],
      child: ScreenUtilInit(
        // Design size based on standard mobile screen dimensions
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeLoad>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Mera Bazaar',
                theme: state.themeData,
                routerConfig: AppRoutes.router,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: const Locale("en"),
              );
            },
          );
        },
      ),
    );
  }
}
