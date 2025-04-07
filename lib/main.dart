import 'main_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorageManager.init();
  await setupDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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

        BlocProvider(create: (context) => getIt<HomeBloc>()),

        BlocProvider(create: (context) => getIt<ProductBloc>()),

        BlocProvider(create: (context) => getIt<CartBloc>()),
      ],
      child: ScreenUtilInit(
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
