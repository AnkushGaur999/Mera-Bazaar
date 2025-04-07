// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserProfileResponse _$GetUserProfileResponseFromJson(
  Map<String, dynamic> json,
) => GetUserProfileResponse(
  name: json['name'] as String?,
  email: json['email'] as String?,
  mobileNumber: json['mobile_number'] as String?,
  profileUrl: json['profile_url'] as String?,
);

Map<String, dynamic> _$GetUserProfileResponseToJson(
  GetUserProfileResponse instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'mobile_number': instance.mobileNumber,
  'profile_url': instance.profileUrl,
};
