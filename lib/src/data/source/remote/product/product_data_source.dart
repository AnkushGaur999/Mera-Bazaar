/// Interface for product data source operations.
///
/// This abstract class defines the contract for making product-related
/// API calls. It includes methods for:
/// - Retrieving products by category
import 'package:mera_bazaar/src/data/models/product/products_response.dart';

/// Abstract class defining the contract for product data source operations.
///
/// This interface should be implemented by concrete classes that handle the actual
/// API calls for product operations. The methods return response models that
/// can be converted to domain entities.
abstract class ProductDataSource {
  /// Retrieves a list of products for the specified category.
  ///
  /// This method should make an API call to get products for the given category ID.
  /// It returns a list of [ProductResponse] containing the API response data.
  ///
  /// [categoryId] - The ID of the category to get products for
  Future<List<ProductResponse>> getProducts({required String categoryId});
}
