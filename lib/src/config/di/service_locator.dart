/// Dependency Injection configuration using GetIt.
///
/// This file sets up the dependency injection container for the application using GetIt.
/// It registers all the necessary dependencies including:
/// - Singletons (services that should have only one instance)
/// - Data Sources (remote data providers)
/// - Repositories (data access layer)
/// - Use Cases (business logic)
/// - BLoCs (state management)
///
/// The setup follows clean architecture principles, ensuring proper separation of concerns
/// and dependency flow from outer layers (data) to inner layers (domain).

import 'package:get_it/get_it.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/repositories/authentication/auth_repository_impl.dart';
import 'package:mera_bazaar/src/data/repositories/cart/cart_repository_impl.dart';
import 'package:mera_bazaar/src/data/repositories/category/category_repository_impl.dart';
import 'package:mera_bazaar/src/data/repositories/home/home_repository_impl.dart';
import 'package:mera_bazaar/src/data/repositories/order/order_repository_impl.dart';
import 'package:mera_bazaar/src/data/repositories/payment/payment_repository_impl.dart';
import 'package:mera_bazaar/src/data/repositories/product/product_repository_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/cart/cart_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/cart/cart_data_source_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/home/home_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/home/home_data_source_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/order/order_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/order/order_data_source_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/payment/payment_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/payment/payment_data_source_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/product/product_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/product/product_data_source_impl.dart';
import 'package:mera_bazaar/src/domain/repositories/auth_repository.dart';
import 'package:mera_bazaar/src/domain/repositories/cart_repository.dart';
import 'package:mera_bazaar/src/domain/repositories/category_repository.dart';
import 'package:mera_bazaar/src/domain/repositories/home_repository.dart';
import 'package:mera_bazaar/src/domain/repositories/order_repository.dart';
import 'package:mera_bazaar/src/domain/repositories/payment_repository.dart';
import 'package:mera_bazaar/src/domain/repositories/product_repository.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/get_user_profile_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/send_otp_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/verify_otp_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/add_to_cart_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/delete_cart_item_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/get_cart_item_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/update_cart_item_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/category/category_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/home/get_carousel_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/order/get_orders_history_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/payment/process_payment_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/product/get_products_use_case.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/cart/cart_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/home/home_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/order/order_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/product/product_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/theme/theme_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/payment/payment_bloc.dart';

/// Global instance of GetIt for dependency injection
GetIt getIt = GetIt.instance;

/// Sets up all dependencies for the application.
///
/// This function registers all dependencies in the following order:
/// 1. Singletons (services that should have only one instance)
/// 2. Data Sources (remote data providers)
/// 3. Repositories (data access layer)
/// 4. Use Cases (business logic)
/// 5. BLoCs (state management)
///
/// The registration follows clean architecture principles, ensuring proper
/// dependency flow from outer layers to inner layers.
Future<void> setupDependencies() async {
  ///
  /// Register Singleton Instance
  ///

  getIt.registerSingleton(LocalStorageManager());
  getIt.registerSingleton(ThemeBloc());
  getIt.registerSingleton<DioClient>(
    DioClient(localStorageManager: getIt<LocalStorageManager>()),
  );

  ///
  /// Register Data Sources
  ///
  ///
  getIt.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<CategoryDataSource>(
    () => CategoryDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<HomeDataSource>(
    () => HomeDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<ProductDataSource>(
    () => ProductDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<CartDataSource>(
    () => CartDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<OrderDataSource>(
    () => OrderDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<PaymentDataSource>(
    () => PaymentDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  ///
  /// Register Repositories
  ///

  getIt.registerFactory<AuthRepository>(
    () => AuthenticationRepositoryImpl(authDataSource: getIt<AuthDataSource>()),
  );

  getIt.registerFactory<CategoryRepository>(
    () =>
        CategoryRepositoryImpl(categoryDataSource: getIt<CategoryDataSource>()),
  );

  getIt.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(homeDataSource: getIt<HomeDataSource>()),
  );

  getIt.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(productDataSource: getIt<ProductDataSource>()),
  );

  getIt.registerFactory<CartRepository>(
    () => CartRepositoryImpl(cartDataSource: getIt<CartDataSource>()),
  );

  getIt.registerFactory<OrderRepository>(
    () => OrderRepositoryImpl(orderDataSource: getIt<OrderDataSource>()),
  );

  getIt.registerFactory<PaymentRepository>(
    () => PaymentRepositoryImpl(paymentDataSource: getIt<PaymentDataSource>()),
  );

  ///
  /// Register Use Cases
  ///

  getIt.registerFactory<SendOtpUseCase>(
    () => SendOtpUseCase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<CategoryUseCase>(
    () => CategoryUseCase(categoryRepository: getIt<CategoryRepository>()),
  );

  getIt.registerFactory<GetCarouselUseCase>(
    () => GetCarouselUseCase(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerFactory<GetProductsUseCase>(
    () => GetProductsUseCase(productRepository: getIt<ProductRepository>()),
  );

  getIt.registerFactory<AddToCartUseCase>(
    () => AddToCartUseCase(repository: getIt<CartRepository>()),
  );

  getIt.registerFactory<GetCartItemsUseCase>(
    () => GetCartItemsUseCase(cartRepository: getIt<CartRepository>()),
  );

  getIt.registerFactory<DeleteCartItemUseCase>(
    () => DeleteCartItemUseCase(repository: getIt<CartRepository>()),
  );

  getIt.registerFactory<UpdateCartItemUseCase>(
    () => UpdateCartItemUseCase(repository: getIt<CartRepository>()),
  );

  getIt.registerFactory<GetOrdersHistoryUseCase>(
    () => GetOrdersHistoryUseCase(repository: getIt<OrderRepository>()),
  );

  getIt.registerFactory(
    () => ProcessPaymentUseCase(paymentRepository: getIt<PaymentRepository>()),
  );

  ///
  /// Register Blocs
  ///

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      sendOtpUseCase: getIt<SendOtpUseCase>(),
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
      userProfileUseCase: getIt<GetUserProfileUseCase>(),
    ),
  );

  getIt.registerFactory<CategoryBloc>(
    () => CategoryBloc(categoryUseCase: getIt<CategoryUseCase>()),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getCarouselUseCase: getIt<GetCarouselUseCase>()),
  );

  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(getProductsUseCase: getIt<GetProductsUseCase>()),
  );

  getIt.registerFactory<CartBloc>(
    () => CartBloc(
      addToCartUseCase: getIt<AddToCartUseCase>(),
      getCartItemsUseCase: getIt<GetCartItemsUseCase>(),
      deleteCartItemUseCase: getIt<DeleteCartItemUseCase>(),
      updateCartItemUseCase: getIt<UpdateCartItemUseCase>(),
    ),
  );

  getIt.registerFactory<OrderBloc>(
    () => OrderBloc(getOrdersHistoryUseCase: getIt<GetOrdersHistoryUseCase>()),
  );

  getIt.registerFactory<PaymentBloc>(
    () => PaymentBloc(processPaymentUseCase: getIt<ProcessPaymentUseCase>()),
  );
}
