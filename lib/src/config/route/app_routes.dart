import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/src/config/di/service_locator.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/account/account_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/cart/cart_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/category/category_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/home_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/notification/notification_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/login/login_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/otp/opt_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/product/product_details_page.dart';
import 'package:mera_bazaar/src/presentation/pages/theme_update_page.dart';
import '../../presentation/pages/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String dashboard = 'dashboard';
  static const String home = 'home';
  static const String profile = 'profile';
  static const String account = 'account';
  static const String notification = 'notification';
  static const String cart = 'cart';
  static const String category = 'category';
  static const String productDetails = 'product_details';
  static const String themeUpdate = 'theme_update';

  static const String _splash = '/';
  static const String _login = '/login';
  static const String _otp = '/otp';
  static const String _dashboard = '/dashboard';
  static const String _home = '/home';
  static const String _profile = '/profile';
  static const String _account = '/account';
  static const String _notification = '/notification';
  static const String _cart = '/cart';
  static const String _category = '/category';
  static const String _productDetails = '/product_details';
  static const String _themeUpdate = '/theme_update';

  static final GoRouter router = GoRouter(
    initialLocation: _splash,
    routes: [
      GoRoute(
        name: splash,
        path: _splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: login,
        path: _login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: otp,
        path: _otp,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        name: dashboard,
        path: _dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        name: home,
        path: _home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: account,
        path: _account,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        name: category,
        path: _category,
        builder: (context, state) => const CategoryScreen(),
      ),

      GoRoute(
        name: productDetails,
        path: _productDetails,
        builder: (context, state) {
          final data = state.extra as ProductEntity;
          return ProductDetailsScreen(productEntity: data);
        },
      ),

      GoRoute(
        name: cart,
        path: _cart,
        builder: (context, state) => const CartScreen(),
      ),

      GoRoute(
        name: themeUpdate,
        path: _themeUpdate,
        builder: (context, state) => const ThemeUpdatePage(),
      ),

      GoRoute(
        name: notification,
        path: _notification,
        builder: (context, state) => const NotificationScreen(),
      ),
    ],
    redirect: (context, state) {
      if (state.path == _cart ||
          state.path == _account ||
          state.path == _notification ||
          state.path == _profile) {
        if (getIt<LocalStorageManager>().token.isEmpty) {
          return _login;
        }

        return null;
      }

      return null;
    },
  );
}
