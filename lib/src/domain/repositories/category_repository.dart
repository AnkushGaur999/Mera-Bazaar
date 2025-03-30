
import 'package:mera_bazaar/src/data/models/category/category_model.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';

abstract class CategoryRepository{

  Future<List<CategoryEntity>> getCategories();

}