/// Authentication events for the authentication BLoC.
///
/// This file defines the events that can be dispatched to the authentication BLoC.
/// These events represent user actions related to authentication, such as:
/// - Sending OTP
/// - Verifying OTP
/// - Retrieving user profile

part of "auth_bloc.dart";

/// Base class for all authentication events.
///
/// This sealed class serves as the base for all authentication-related events.
/// It extends [Equatable] to allow for easy comparison of events.
sealed class AuthEvent extends Equatable {}

/// Event for sending an OTP to a phone number.
///
/// This event is dispatched when the user enters their phone number
/// and requests an OTP for authentication.
class SendOtpEvent extends AuthEvent {
  /// The phone number to send the OTP to
  final String number;

  /// Creates a new [SendOtpEvent] with the specified phone number.
  ///
  /// [number] - The phone number to send the OTP to
  SendOtpEvent({required this.number});

  @override
  List<Object?> get props => [number];
}

/// Event for verifying an OTP.
///
/// This event is dispatched when the user enters the OTP they received
/// and wants to verify it.
class VerifyOtpEvent extends AuthEvent {
  /// The phone number the OTP was sent to
  final String number;

  /// The OTP entered by the user
  final String otp;

  /// Creates a new [VerifyOtpEvent] with the specified phone number and OTP.
  ///
  /// [number] - The phone number the OTP was sent to
  /// [otp] - The OTP entered by the user
  VerifyOtpEvent({required this.number, required this.otp});

  @override
  List<Object?> get props => [number, otp];
}

/// Event for retrieving the user's profile.
///
/// This event is dispatched when the application needs to fetch the
/// authenticated user's profile information.
class GetUserProfileEvent extends AuthEvent {
  /// The authentication token to use for the request
  final String token;

  /// Creates a new [GetUserProfileEvent] with the specified token.
  ///
  /// [token] - The authentication token to use for the request
  GetUserProfileEvent({required this.token});

  @override
  List<Object?> get props => [token];
}
