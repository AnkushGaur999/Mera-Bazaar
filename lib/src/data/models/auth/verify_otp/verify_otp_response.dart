import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/auth/verify_otp_response_entity.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  bool? success;
  String? message;
  bool? error;
  VerifyOtpData? data;

  VerifyOtpResponse({this.success, this.message, this.error, this.data});

  factory VerifyOtpResponse.formJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);

  VerifyOtpResponseEntity toEntity() {
    return VerifyOtpResponseEntity(
      success: success,
      message: message,
      error: error,
      data: data
    );
  }
}

@JsonSerializable()
class VerifyOtpData {
  String? token;
  String? number;
  String? name;
  String? profileUrl;
  String? email;

  VerifyOtpData();

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDataFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpDataToJson(this);
}
