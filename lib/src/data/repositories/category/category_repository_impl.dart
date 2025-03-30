import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource categoryDataSource;

  CategoryRepositoryImpl({required this.categoryDataSource});

  @override
  Future<List<CategoryEntity>> getCategories() async {
      final data = await categoryDataSource.getCategory();
      return data.map((e) => e.toEntity(e)).toList();
  }
}
