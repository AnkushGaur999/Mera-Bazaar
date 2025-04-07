import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class SendOtpResponseEntity extends Equatable {
  final bool? success;
  final String? message;
  final bool? error;

  const SendOtpResponseEntity({
    this.success,
    this.message,
    this.error,
  });

  @override
  List<Object?> get props => [
        success,
        message,
        error,
      ];
}
