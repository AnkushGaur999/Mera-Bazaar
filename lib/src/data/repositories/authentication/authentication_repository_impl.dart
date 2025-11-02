/// Implementation of the authentication repository.
///
/// This class implements the [AuthenticationRepository] interface and provides
/// concrete implementations for authentication-related operations such as:
/// - Sending OTP
/// - Verifying OTP
/// - Retrieving user profile
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/auth/get_user_profile_entity.dart';
import 'package:mera_bazaar/src/domain/entities/auth/phone_auth_result.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';

/// A concrete implementation of the [AuthenticationRepository] interface.
///
/// This class handles the actual API calls through the [AuthDataSource] and
/// converts the responses to domain entities. It also handles error cases by
/// converting Dio exceptions to [MyBazaarException]s.
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  /// The data source used to make API calls
  final AuthDataSource authDataSource;

  /// Creates a new instance of [AuthenticationRepositoryImpl].
  ///
  /// Requires an [AuthDataSource] to be provided for making API calls.
  AuthenticationRepositoryImpl({required this.authDataSource});

  /// Sends an OTP to the specified phone number.
  ///
  /// This method delegates the API call to the [authDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A [User] on success
  /// - A [MyBazaarException] on failure
  @override
  Future<DataState<User>> login({
    required String email,
    required String password,
  }) async {
    final response = await authDataSource.login(email, password);

    if (response is DataSuccess) {
      return DataSuccess(data: response.data!);
    } else {
      return DataError(exception: response.exception!);
    }
  }

  @override
  /// Sends an OTP to the specified phone number.
  ///
  /// This method delegates the API call to the [authDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A [PhoneAuthResult] on success
  /// - A [MyBazaarException] on failure
  Future<DataState<PhoneAuthResult>> sendOTP({required String number}) async {
    try {
      final response = await authDataSource.sendOtp(number);

      if (response.success) {
        return DataSuccess(data: response);
      } else {
        return DataError(
          exception: MyBazaarException.fromException(
            const FormatException(),
            message: response.message,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }

  @override
  /// Verifies an OTP for the specified phone number.
  ///
  /// This method delegates the API call to the [authDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A [PhoneAuthResult] on success
  /// - A [MyBazaarException] on failure
  Future<DataState<PhoneAuthResult>> verifyOTP({
    required String number,
    required String otp,
  }) async {
    try {
      final response = await authDataSource.verifyOtp(number, otp);
      if (response.success) {
        return DataSuccess(data: response);
      } else {
        return DataError(
          exception: MyBazaarException.fromException(
            const FormatException(),
            message: response.message,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }

  @override
  /// Retrieves the user profile for the specified token.
  ///
  /// This method delegates the API call to the [authDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A [GetUserProfileEntity] on success
  /// - A [MyBazaarException] on failure
  Future<DataState<GetUserProfileEntity>> getUserProfile({
    required String token,
  }) async {
    try {
      final response = await authDataSource.getUserProfile(token: token);
      return DataSuccess(data: response.toEntity());
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }
}
