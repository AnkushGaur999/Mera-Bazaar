/// Interface for authentication data source operations.
///
/// This abstract class defines the contract for making authentication-related
/// API calls. It includes methods for:
/// - Sending OTP
/// - Verifying OTP
/// - Retrieving user profile
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/models/auth/get_user_profile/get_user_profile_response.dart';
import 'package:mera_bazaar/src/data/models/auth/send_otp/send_otp_response.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';
import 'package:mera_bazaar/src/domain/entities/auth/phone_auth_result.dart';

/// Abstract class defining the contract for authentication data source operations.
///
/// This interface should be implemented by concrete classes that handle the actual
/// API calls for authentication operations. The methods return response models that
/// can be converted to domain entities.
abstract class AuthDataSource {
  /// Login with email and password.
  ///
  /// This method should make an API call to verify email and password.
  /// It returns a [SendOtpResponse] containing the API response data.
  ///
  /// [number] - The phone number to send the OTP to
  Future<DataState<User>> login(String email, String password);

  /// Sends an OTP to the specified phone number.
  ///
  /// This method should make an API call to send an OTP to the given phone number.
  /// It returns a [SendOtpResponse] containing the API response data.
  ///
  /// [number] - The phone number to send the OTP to
  Future<PhoneAuthResult> sendOtp(String number);

  /// Verifies an OTP for the specified verification ID.
  ///
  /// This method should make an API call to verify the OTP for the given
  /// verification ID. It returns a [VerifyOtpResponse] containing the API response data.
  ///
  /// [verificationId] - The ID of the verification process
  /// [otp] - The OTP code to verify
  Future<PhoneAuthResult> verifyOtp(String verificationId, String otp);

  /// Retrieves the user profile for the specified token.
  ///
  /// This method should make an API call to get the user profile using the
  /// provided authentication token. It returns a [GetUserProfileResponse]
  /// containing the API response data.
  ///
  /// [token] - The authentication token to use for the request
  Future<GetUserProfileResponse> getUserProfile({required String token});
}
