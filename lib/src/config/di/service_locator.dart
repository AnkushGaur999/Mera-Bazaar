import 'package:get_it/get_it.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/repositories/authentication/authentication_repository_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source_impl.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/send_otp_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/verify_otp_use_case.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<DioClient>(DioClient());

  getIt.registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(dioClient: getIt<DioClient>()));

  getIt.registerFactory<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(authDataSource: getIt<AuthDataSource>()));

  getIt.registerFactory<SendOtpUseCase>(() => SendOtpUseCase(
      authenticationRepository: getIt<AuthenticationRepository>()));

  getIt.registerFactory<VerifyOtpUseCase>(() => VerifyOtpUseCase(
      authenticationRepository: getIt<AuthenticationRepository>()));

  getIt.registerFactory<AuthBloc>(() => AuthBloc(
      sendOtpUseCase: getIt<SendOtpUseCase>(),
      verifyOtpUseCase: getIt<VerifyOtpUseCase>()));
}
