import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/auth/get_user_profile_entity.dart';

part 'get_user_profile_response.g.dart';

@JsonSerializable()
class GetUserProfileResponse {
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "mobile_number")
  String? mobileNumber;

  @JsonKey(name: "profile_url")
  String? profileUrl;

  GetUserProfileResponse({
    this.name,
    this.email,
    this.mobileNumber,
    this.profileUrl,
  });

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileResponseToJson(this);

  GetUserProfileEntity toEntity() {
    return GetUserProfileEntity(
      name: name,
      email: email,
      mobileNumber: mobileNumber,
      imageUrl: profileUrl,
    );
  }
}
