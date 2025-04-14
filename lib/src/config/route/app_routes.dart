/// Application routing configuration using GoRouter.
///
/// This file defines all the routes available in the application and their corresponding
/// screens. It also handles route protection for authenticated routes.
///
/// The routing system uses GoRouter for navigation, which provides a more flexible
/// and type-safe way to handle navigation compared to traditional Navigator.

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
import 'package:mera_bazaar/src/presentation/pages/order/orders_history_page.dart';
import 'package:mera_bazaar/src/presentation/pages/otp/opt_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/product/product_details_page.dart';
import 'package:mera_bazaar/src/presentation/pages/theme_update_page.dart';
import '../../presentation/pages/splash/splash_screen.dart';

/// Contains all route names and paths used in the application.
///
/// This class provides a centralized place for managing route names and paths,
/// making it easier to maintain and update routes throughout the application.
class AppRoutes {
  /// Route names for navigation
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
  static const String orderHistory = 'order_history';

  /// Route paths for URL matching
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
  static const String _orderHistory = '/order_history';

  /// The main router configuration for the application.
  ///
  /// This router:
  /// 1. Sets the initial route to splash screen
  /// 2. Defines all available routes and their corresponding screens
  /// 3. Handles route protection for authenticated routes (cart, account, notifications)
  /// 4. Redirects unauthenticated users to the login screen when accessing protected routes
  static final GoRouter router = GoRouter(
    initialLocation: _splash,
    routes: [
      // Public routes
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

      // Dashboard and main navigation
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

      // Protected routes (require authentication)
      GoRoute(
        name: account,
        path: _account,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        name: category,
        path: _category,
        builder:
            (context, state) =>
                CategoryScreen(categoryId: state.extra as String),
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

      GoRoute(
        name: orderHistory,
        path: _orderHistory,
        builder: (context, state) => const OrdersHistoryPage(),
      ),
    ],

    /// Route protection logic
    ///
    /// Checks if the user is authenticated when accessing protected routes.
    /// Redirects to login screen if the user is not authenticated.
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
