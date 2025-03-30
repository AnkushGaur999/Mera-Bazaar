import 'package:get_it/get_it.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/repositories/authentication/authentication_repository_impl.dart';
import 'package:mera_bazaar/src/data/repositories/category/category_repository_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source_impl.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';
import 'package:mera_bazaar/src/domain/repositories/category_repository.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/send_otp_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/verify_otp_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/category/category_use_case.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton(LocalStorageManager());

  getIt.registerSingleton<DioClient>(
    DioClient(localStorageManager: getIt<LocalStorageManager>()),
  );

  ///
  /// Register Repositories
  ///

  getIt.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<CategoryDataSource>(
    () => CategoryDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerFactory<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(authDataSource: getIt<AuthDataSource>()),
  );

  getIt.registerFactory<CategoryRepository>(
    () =>
        CategoryRepositoryImpl(categoryDataSource: getIt<CategoryDataSource>()),
  );

  ///
  /// Register Use Cases
  ///

  getIt.registerFactory<SendOtpUseCase>(
    () => SendOtpUseCase(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );

  getIt.registerFactory<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );

  getIt.registerFactory<CategoryUseCase>(
    () => CategoryUseCase(categoryRepository: getIt<CategoryRepository>()),
  );

  ///
  /// Register Blocs
  ///

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      sendOtpUseCase: getIt<SendOtpUseCase>(),
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
    ),
  );

  getIt.registerFactory<CategoryBloc>(
    () => CategoryBloc(categoryUseCase: getIt<CategoryUseCase>()),
  );
}
