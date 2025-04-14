/// Implementation of the category data source.
///
/// This class implements the [CategoryDataSource] interface and provides
/// concrete implementations for category-related API calls using Firestore.
/// It handles retrieving categories from the Firestore database.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/category/category_model.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';

/// A concrete implementation of the [CategoryDataSource] interface.
///
/// This class uses Firestore to retrieve category data from the database.
/// It handles querying categories and converting the Firestore
/// documents to [CategoryModel] models.
class CategoryDataSourceImpl extends CategoryDataSource {
  /// The Dio client for making HTTP requests
  final DioClient dioClient;

  /// The Firestore instance for database operations
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// Creates a new instance of [CategoryDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  CategoryDataSourceImpl({required this.dioClient});

  @override
  /// Retrieves a list of all categories.
  ///
  /// This method queries the Firestore database to get all documents from the
  /// "categories" collection, ordered by name. It converts each document to a
  /// [CategoryModel] and sets the document ID as the model's ID.
  ///
  /// Returns a list of [CategoryModel] containing the category data.
  Future<List<CategoryModel>> getCategory() async {
    try {
      final result =
          await _fireStore.collection("categories").orderBy("name").get();

      final List<CategoryModel> categoryList = [];

      for (final category in result.docs) {
        final categoryModel = CategoryModel.fromJson(category.data());
        categoryModel.id = category.id;
        categoryList.add(categoryModel);
      }

      return categoryList;
    } catch (e) {
      rethrow;
    }
  }
}
