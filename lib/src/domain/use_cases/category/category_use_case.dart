import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/category_repository.dart';

class CategoryUseCase{

  final CategoryRepository categoryRepository;

  CategoryUseCase({required this.categoryRepository});

  Future<List<CategoryEntity>> call()async{
    return categoryRepository.getCategories();
  }

}