import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource categoryDataSource;

  CategoryRepositoryImpl({required this.categoryDataSource});

  @override
  Future<DataState<List<CategoryEntity>>> getCategories() async {
    try {
      final data = await categoryDataSource.getCategory();
      return DataSuccess(data: data.map((e) => e.toEntity(e)).toList());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }
}
