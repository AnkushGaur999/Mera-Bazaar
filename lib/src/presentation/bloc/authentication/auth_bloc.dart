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

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final GetUserProfileUseCase userProfileUseCase;

  AuthBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.userProfileUseCase,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<VerifyOtpEvent>(_verifyOTP);
    on<GetUserProfileEvent>(_getUserProfile);
  }

  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(SendOtpLoading());

    final response = await sendOtpUseCase.sendOtp(number: event.number);

    if (response is DataSuccess) {
      emit(SendOtpSuccess(message: response.data!.message!));
    } else {
      emit(SendOtpError(message: response.exception!.message));
    }
  }

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
