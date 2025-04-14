/// Authentication BLoC implementation.
///
/// This file defines the authentication BLoC, which manages the state of
/// authentication-related operations in the application. It handles:
/// - Sending OTP
/// - Verifying OTP
/// - Retrieving user profile

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mera_bazaar/src/config/di/service_locator.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/get_user_profile_entity.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/get_user_profile_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/send_otp_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/auth/verify_otp_use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// BLoC for managing authentication operations.
///
/// This class extends [Bloc] to manage the state of authentication operations.
/// It handles events related to:
/// - Sending OTP
/// - Verifying OTP
/// - Retrieving user profile
///
/// The BLoC uses use cases to perform the actual operations and emits
/// appropriate states based on the results.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Use case for sending OTP
  final SendOtpUseCase sendOtpUseCase;

  /// Use case for verifying OTP
  final VerifyOtpUseCase verifyOtpUseCase;

  /// Use case for retrieving user profile
  final GetUserProfileUseCase userProfileUseCase;

  /// Creates a new [AuthBloc] with the specified use cases.
  ///
  /// [sendOtpUseCase] - Use case for sending OTP
  /// [verifyOtpUseCase] - Use case for verifying OTP
  /// [userProfileUseCase] - Use case for retrieving user profile
  AuthBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.userProfileUseCase,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<VerifyOtpEvent>(_verifyOTP);
    on<GetUserProfileEvent>(_getUserProfile);
  }

  /// Handles the [SendOtpEvent] event.
  ///
  /// This method is called when a [SendOtpEvent] is dispatched to the BLoC.
  /// It emits a [SendOtpLoading] state, then calls the [sendOtpUseCase] to send the OTP.
  /// Based on the result, it emits either a [SendOtpSuccess] or [SendOtpError] state.
  ///
  /// [event] - The event to handle
  /// [emit] - The emitter to use for emitting states
  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(SendOtpLoading());

    final response = await sendOtpUseCase.sendOtp(number: event.number);

    if (response is DataSuccess) {
      emit(SendOtpSuccess(message: response.data!.message!));
    } else {
      emit(SendOtpError(message: response.exception!.message));
    }
  }

  /// Handles the [VerifyOtpEvent] event.
  ///
  /// This method is called when a [VerifyOtpEvent] is dispatched to the BLoC.
  /// It emits a [VerifyOtpLoading] state, then calls the [verifyOtpUseCase] to verify the OTP.
  /// If successful, it stores the authentication token in local storage.
  /// Based on the result, it emits either a [VerifyOtpSuccess] or [VerifyOtpError] state.
  ///
  /// [event] - The event to handle
  /// [emit] - The emitter to use for emitting states
  Future<void> _verifyOTP(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(VerifyOtpLoading());
    final response = await verifyOtpUseCase.sendOtp(
      number: event.number,
      otp: event.otp,
    );

    if (response is DataSuccess) {
      getIt<LocalStorageManager>().setToken(
        "uhdsi7823hew89hisid90jkds8sdm2u3h",
      );
      emit(VerifyOtpSuccess(message: response.data!.message!));
    } else {
      emit(VerifyOtpError(message: response.exception!.message));
    }
  }

  /// Handles the [GetUserProfileEvent] event.
  ///
  /// This method is called when a [GetUserProfileEvent] is dispatched to the BLoC.
  /// It emits a [GetUserProfileLoading] state, then calls the [userProfileUseCase] to get the user profile.
  /// Based on the result, it emits either a [GetUserProfileSuccess] or [GetUserProfileError] state.
  ///
  /// [event] - The event to handle
  /// [emit] - The emitter to use for emitting states
  Future<void> _getUserProfile(
    GetUserProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(GetUserProfileLoading());

    final response = await userProfileUseCase.call(token: event.token);

    if (response is DataSuccess) {
      emit(GetUserProfileSuccess(userData: response.data!));
    } else {
      emit(GetUserProfileError(message: response.exception!.message));
    }
  }
}
