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

// BLoC Exports
export 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/home/home_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/theme/theme_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/product/product_bloc.dart';
export 'package:mera_bazaar/src/presentation/bloc/cart/cart_bloc.dart';

// Dependency Injection
export 'src/config/di/service_locator.dart';

// Localization
export 'package:flutter_gen/gen_l10n/app_localizations.dart';
