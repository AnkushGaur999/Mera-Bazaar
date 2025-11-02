/// Main exports file for the Mera Bazaar application.
///
/// This file centralizes all the important imports and exports used throughout the application.
/// It helps maintain clean import statements in other files and provides a single source
/// for commonly used dependencies.

// Firebase Core
export 'package:firebase_core/firebase_core.dart';

// Flutter Core
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

// State Management
export 'package:flutter_bloc/flutter_bloc.dart';

// UI Utilities
export 'package:flutter_screenutil/flutter_screenutil.dart';

// Application Routes
export 'package:mera_bazaar/src/config/route/app_routes.dart';

// Local Storage
export 'package:mera_bazaar/src/core/local/local_storage_manager.dart';

// Firebase Configuration
export 'package:mera_bazaar/src/core/utils/firebase_options.dart';

// Firebase Analytics
export 'package:firebase_analytics/firebase_analytics.dart';

// BLoC Exports
export 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/home/home_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/theme/theme_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/product/product_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/cart/cart_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/order/order_bloc.dart';

// Dependency Injection
export 'src/config/di/service_locator.dart';

// Notification Service
export 'package:mera_bazaar/src/config/services/notification_service.dart';

// Flavor Config
export 'package:mera_bazaar/src/config/flavors/flavor_config.dart';

export  'package:flutter_localizations/flutter_localizations.dart';
export 'package:mera_bazaar/generated/l10n.dart';



