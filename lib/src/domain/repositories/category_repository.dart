
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';

abstract class CategoryRepository{

  Future<DataState<List<CategoryEntity>>> getCategories();

}