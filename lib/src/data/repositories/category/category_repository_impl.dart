/// Implementation of the category repository.
///
/// This class implements the [CategoryRepository] interface and provides
/// concrete implementations for category-related operations such as:
/// - Retrieving all categories
import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/category_repository.dart';

/// A concrete implementation of the [CategoryRepository] interface.
///
/// This class handles the actual API calls through the [CategoryDataSource] and
/// converts the responses to domain entities. It also handles error cases by
/// converting exceptions to [MyBazaarException]s.
class CategoryRepositoryImpl extends CategoryRepository {
  /// The data source used to make API calls
  final CategoryDataSource categoryDataSource;

  /// Creates a new instance of [CategoryRepositoryImpl].
  ///
  /// Requires a [CategoryDataSource] to be provided for making API calls.
  CategoryRepositoryImpl({required this.categoryDataSource});

  @override
  /// Retrieves a list of all categories.
  ///
  /// This method delegates the API call to the [categoryDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A list of [CategoryEntity] on success
  /// - A [MyBazaarException] on failure
  Future<DataState<List<CategoryEntity>>> getCategories() async {
    try {
      final data = await categoryDataSource.getCategory();
      return DataSuccess(data: data.map((e) => e.toEntity(e)).toList());
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }
}
