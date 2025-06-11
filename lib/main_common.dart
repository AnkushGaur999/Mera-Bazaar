import 'package:mera_bazaar/src/presentation/my_app.dart';
import 'main_export.dart';

/// Mera Bazaar - A Flutter-based e-commerce application
///
/// This file contains the main entry point of the application and the root widget.
/// It initializes Firebase, sets up dependencies, and configures the app's theme and routing.

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

void mainCommon({
  required Flavor flavor,
  required String baseUrl,
  required String name,
}) async {
  FlavorConfig(flavor: flavor, baseUrl: baseUrl, name: name);

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
