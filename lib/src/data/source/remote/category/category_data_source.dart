import 'package:mera_bazaar/src/data/models/category/category_model.dart';

abstract class CategoryDataSource{

  Future<List<CategoryModel>> getCategory();

}