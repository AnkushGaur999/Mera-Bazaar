/// Implementation of the product repository.
///
/// This class implements the [ProductRepository] interface and provides
/// concrete implementations for product-related operations such as:
/// - Retrieving products by category
import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/product/product_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/product_repository.dart';

/// A concrete implementation of the [ProductRepository] interface.
///
/// This class handles the actual API calls through the [ProductDataSource] and
/// converts the responses to domain entities. It also handles error cases by
/// converting exceptions to [NetworkException]s.
class ProductRepositoryImpl extends ProductRepository {
  /// The data source used to make API calls
  final ProductDataSource productDataSource;

  /// Creates a new instance of [ProductRepositoryImpl].
  ///
  /// Requires a [ProductDataSource] to be provided for making API calls.
  ProductRepositoryImpl({required this.productDataSource});

  @override
  /// Retrieves a list of products for the specified category.
  ///
  /// This method delegates the API call to the [productDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [NetworkException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A list of [ProductEntity] on success
  /// - A [NetworkException] on failure
  ///
  /// [categoryId] - The ID of the category to get products for
  Future<DataState<List<ProductEntity>>> getProducts({
    required String categoryId,
  }) async {
    try {
      final response = await productDataSource.getProducts(
        categoryId: categoryId,
      );
      return DataSuccess(data: response.map((e) => e.toEntity(e)).toList());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }
}
