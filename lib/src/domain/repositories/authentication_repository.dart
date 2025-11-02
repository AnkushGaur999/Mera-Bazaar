import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/get_user_profile_entity.dart';
import 'package:mera_bazaar/src/domain/entities/auth/phone_auth_result.dart';


abstract class AuthenticationRepository {
  Future<DataState<User>> login({
    required String email,
    required String password,
  });

  Future<DataState<PhoneAuthResult>> sendOTP({required String number});

  Future<DataState<PhoneAuthResult>> verifyOTP({
    required String phone,
    required String otp,
    required String verificationId,
  });

  Future<DataState<GetUserProfileEntity>> getUserProfile({
    required String token,
  });
}
