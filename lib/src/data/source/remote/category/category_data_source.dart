/// Interface for category data source operations.
///
/// This abstract class defines the contract for making category-related
/// API calls. It includes methods for:
/// - Retrieving all categories
import 'package:mera_bazaar/src/data/models/category/category_model.dart';

/// Abstract class defining the contract for category data source operations.
///
/// This interface should be implemented by concrete classes that handle the actual
/// API calls for category operations. The methods return response models that
/// can be converted to domain entities.
abstract class CategoryDataSource {
  /// Retrieves a list of all categories.
  ///
  /// This method should make an API call to get all categories.
  /// It returns a list of [CategoryModel] containing the category data.
  Future<List<CategoryModel>> getCategory();
}
