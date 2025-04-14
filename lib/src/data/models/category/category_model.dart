import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "image_url")
  String? imageUrl;

  @JsonKey(name: "description")
  String? description;

  CategoryModel({this.id, this.name, this.imageUrl, this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toEntity(CategoryModel category) {
    return CategoryEntity(
      id: category.id,
      name: category.name,
      imageUrl: category.imageUrl,
      description: category.description,
    );
  }
}
