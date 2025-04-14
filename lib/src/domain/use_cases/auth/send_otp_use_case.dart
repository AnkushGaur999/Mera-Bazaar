/// Use case for sending OTP to a phone number.
///
/// This use case encapsulates the business logic for sending an OTP to a user's
/// phone number. It delegates the actual API call to the authentication repository
/// and returns a [DataState] containing either the OTP response or an error.
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/send_otp_response_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';

/// A use case that handles sending OTP to a phone number.
///
/// This class follows the clean architecture pattern by:
/// 1. Taking a repository as a dependency
/// 2. Providing a single public method that encapsulates the business logic
/// 3. Returning a [DataState] to handle success and error cases
class SendOtpUseCase {
  /// The authentication repository used to make the API call.
  final AuthenticationRepository authenticationRepository;

  /// Creates a new instance of [SendOtpUseCase].
  ///
  /// Requires an [AuthenticationRepository] to be provided for making the API call.
  SendOtpUseCase({required this.authenticationRepository});

  /// Sends an OTP to the specified phone number.
  ///
  /// Returns a [DataState] containing either:
  /// - A [SendOtpResponseEntity] on success
  /// - An error message on failure
  ///
  /// The [number] parameter should be a valid phone number in the correct format.
  Future<DataState<SendOtpResponseEntity>> sendOtp({
    required String number,
  }) async {
    return await authenticationRepository.sendOTP(number: number);
  }
}
