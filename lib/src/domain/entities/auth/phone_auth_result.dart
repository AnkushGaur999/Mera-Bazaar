import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

class PhoneAuthResult extends Equatable {
  final bool success;
  final String message;
  final String? verificationId;
  final int? resendToken;
  final User? user;
  final ConfirmationResult? confirmationResult; // For web flow

  const PhoneAuthResult({
    required this.success,
    required this.message,
    this.verificationId,
    this.resendToken,
    this.user,
    this.confirmationResult,
  });

  @override
  List<Object?> get props => [verificationId, resendToken, user, confirmationResult];
}