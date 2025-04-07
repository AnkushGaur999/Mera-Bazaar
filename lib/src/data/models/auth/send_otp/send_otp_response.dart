import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/auth/send_otp_response_entity.dart';

part 'send_otp_response.g.dart';

@JsonSerializable()
class SendOtpResponse {
  bool? success;
  String? message;
  bool? error;

  SendOtpResponse({this.success, this.message, this.error});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpResponseToJson(this);

  SendOtpResponseEntity toEntity() {
    return SendOtpResponseEntity(
      success: success,
      message: message,
      error: error,
    );
  }
}
