// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponse _$VerifyOtpResponseFromJson(Map<String, dynamic> json) =>
    VerifyOtpResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as bool?,
      data:
          json['data'] == null
              ? null
              : VerifyOtpData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyOtpResponseToJson(VerifyOtpResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };

VerifyOtpData _$VerifyOtpDataFromJson(Map<String, dynamic> json) =>
    VerifyOtpData()
      ..token = json['token'] as String?
      ..number = json['number'] as String?
      ..name = json['name'] as String?
      ..profileUrl = json['profileUrl'] as String?
      ..email = json['email'] as String?;

Map<String, dynamic> _$VerifyOtpDataToJson(VerifyOtpData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'number': instance.number,
      'name': instance.name,
      'profileUrl': instance.profileUrl,
      'email': instance.email,
    };
