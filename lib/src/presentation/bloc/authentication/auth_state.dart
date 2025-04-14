/// Authentication states for the authentication BLoC.
///
/// This file defines the states that can be emitted by the authentication BLoC.
/// These states represent the different stages of authentication processes, such as:
/// - Initial state
/// - Loading states
/// - Success states with data
/// - Error states with messages

part of "auth_bloc.dart";

/// Base class for all authentication states.
///
/// This sealed class serves as the base for all authentication-related states.
/// It extends [Equatable] to allow for easy comparison of states.
sealed class AuthState extends Equatable {}

/// The initial state of the authentication BLoC.
///
/// This state is emitted when the BLoC is first created and no
/// authentication operations have been performed yet.
class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

/// State indicating that an OTP is being sent.
///
/// This state is emitted when the BLoC is processing a request to send an OTP.
class SendOtpLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

/// State indicating that an OTP was successfully sent.
///
/// This state is emitted when the OTP has been successfully sent to the user's phone.
class SendOtpSuccess extends AuthState {
  /// A message indicating the success of the operation
  final String message;

  /// Creates a new [SendOtpSuccess] state with the specified message.
  ///
  /// [message] - A message indicating the success of the operation
  SendOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// State indicating that sending an OTP failed.
///
/// This state is emitted when there was an error sending the OTP.
class SendOtpError extends AuthState {
  /// A message describing the error that occurred
  final String message;

  /// Creates a new [SendOtpError] state with the specified message.
  ///
  /// [message] - A message describing the error that occurred
  SendOtpError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// State indicating that an OTP is being verified.
///
/// This state is emitted when the BLoC is processing a request to verify an OTP.
class VerifyOtpLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

/// State indicating that an OTP was successfully verified.
///
/// This state is emitted when the OTP has been successfully verified.
class VerifyOtpSuccess extends AuthState {
  /// A message indicating the success of the operation
  final String message;

  /// Creates a new [VerifyOtpSuccess] state with the specified message.
  ///
  /// [message] - A message indicating the success of the operation
  VerifyOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// State indicating that verifying an OTP failed.
///
/// This state is emitted when there was an error verifying the OTP.
class VerifyOtpError extends AuthState {
  /// A message describing the error that occurred
  final String message;

  /// Creates a new [VerifyOtpError] state with the specified message.
  ///
  /// [message] - A message describing the error that occurred
  VerifyOtpError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// State indicating that the user profile is being retrieved.
///
/// This state is emitted when the BLoC is processing a request to get the user's profile.
class GetUserProfileLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

/// State indicating that the user profile was successfully retrieved.
///
/// This state is emitted when the user's profile has been successfully retrieved.
class GetUserProfileSuccess extends AuthState {
  /// The user profile data
  final GetUserProfileEntity userData;

  /// Creates a new [GetUserProfileSuccess] state with the specified user data.
  ///
  /// [userData] - The user profile data
  GetUserProfileSuccess({required this.userData});

  @override
  List<Object?> get props => [userData];
}

/// State indicating that retrieving the user profile failed.
///
/// This state is emitted when there was an error retrieving the user's profile.
class GetUserProfileError extends AuthState {
  /// A message describing the error that occurred
  final String message;

  /// Creates a new [GetUserProfileError] state with the specified message.
  ///
  /// [message] - A message describing the error that occurred
  GetUserProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
