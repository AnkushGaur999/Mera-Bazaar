import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/home/carousel_entity.dart';

part 'get_carousels_response.g.dart';

@JsonSerializable()
class GetCarouselsResponse {
  @JsonKey(name: "image_url")
  final String? imageUrl;

  @JsonKey(name: "description")
  final String? description;

  GetCarouselsResponse({this.imageUrl, this.description});

  factory GetCarouselsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCarouselsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCarouselsResponseToJson(this);

  @override
  String toString() {
    return 'GetCarouselsResponse(imageUrl: $imageUrl, description: $description)';
  }

  CarouselEntity toEntity(GetCarouselsResponse instance) => CarouselEntity(
    imageUrl: instance.imageUrl,
    description: instance.description,
  );
}
