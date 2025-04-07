import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/auth/get_user_profile_entity.dart';
import 'package:mera_bazaar/src/domain/entities/auth/send_otp_response_entity.dart';
import 'package:mera_bazaar/src/domain/entities/auth/verify_otp_response_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthDataSource authDataSource;

  AuthenticationRepositoryImpl({required this.authDataSource});

  @override
  Future<DataState<SendOtpResponseEntity>> sendOTP({
    required String number,
  }) async {
    try {
      final response = await authDataSource.sendOtp(number);

      return DataSuccess(data: response.toEntity());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    }
  }

  @override
  Future<DataState<VerifyOtpResponseEntity>> verifyOTP({
    required String number,
    required String otp,
  }) async {
    try {
      // final data = {"number": number, "otp": otp};

      final response = await authDataSource.verifyOtp(number, otp);
      return DataSuccess(data: response.toEntity());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    }
  }

  @override
  Future<DataState<GetUserProfileEntity>> getUserProfile({
    required String token,
  }) async {
    try {
      // final data = {"number": number, "otp": otp};

      final response = await authDataSource.getUserProfile(token: token);
      return DataSuccess(data: response.toEntity());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    }
  }
}
