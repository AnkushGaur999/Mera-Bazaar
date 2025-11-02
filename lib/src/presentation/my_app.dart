
import 'package:mera_bazaar/main_export.dart';


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
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  ],
                supportedLocales: S.delegate.supportedLocales,
                locale: const Locale('en'),
              );
            },
          );
        },
      ),
    );
  }
}
