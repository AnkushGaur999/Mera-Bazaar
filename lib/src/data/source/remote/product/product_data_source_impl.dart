/// Implementation of the product data source.
///
/// This class implements the [ProductDataSource] interface and provides
/// concrete implementations for product-related API calls using Firestore.
/// It handles retrieving products by category from the Firestore database.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/product/products_response.dart';
import 'package:mera_bazaar/src/data/source/remote/product/product_data_source.dart';

/// A concrete implementation of the [ProductDataSource] interface.
///
/// This class uses Firestore to retrieve product data from the database.
/// It handles querying products by category and converting the Firestore
/// documents to [ProductResponse] models.
class ProductDataSourceImpl extends ProductDataSource {
  /// The Dio client for making HTTP requests
  final DioClient dioClient;

  /// The Firestore instance for database operations
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// Creates a new instance of [ProductDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  ProductDataSourceImpl({required this.dioClient});

  @override
  /// Retrieves a list of products for the specified category.
  ///
  /// This method queries the Firestore database to get products for the given
  /// category ID. If the category ID is "YsXVA7X1EgWrpUWvpf8f", it retrieves
  /// all products. Otherwise, it filters products by the specified category ID.
  ///
  /// Returns a list of [ProductResponse] containing the product data.
  ///
  /// [categoryId] - The ID of the category to get products for
  Future<List<ProductResponse>> getProducts({
    required String categoryId,
  }) async {
    final List<ProductResponse> products = [];

    final productDocs =
        categoryId == "YsXVA7X1EgWrpUWvpf8f"
            ? await _fireStore.collection("products").get()
            : await _fireStore
                .collection("products")
                .where("category_id", isEqualTo: categoryId)
                .get();

    for (var i = 0; i < productDocs.docs.length; i++) {
      products.add(ProductResponse.fromJson(productDocs.docs[i].data()));
    }

    return products;
  }
}
