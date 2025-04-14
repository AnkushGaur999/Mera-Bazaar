/// Implementation of the home data source.
///
/// This class implements the [HomeDataSource] interface and provides
/// concrete implementations for home-related API calls using Firestore.
/// It handles retrieving carousel items from the Firestore database.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/home/get_carousels_response.dart';
import 'package:mera_bazaar/src/data/source/remote/home/home_data_source.dart';

/// A concrete implementation of the [HomeDataSource] interface.
///
/// This class uses Firestore to retrieve carousel data from the database.
/// It handles querying carousel items and converting the Firestore
/// documents to [GetCarouselsResponse] models.
class HomeDataSourceImpl extends HomeDataSource {
  /// The Dio client for making HTTP requests
  final DioClient dioClient;

  /// The Firestore instance for database operations
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// Creates a new instance of [HomeDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  HomeDataSourceImpl({required this.dioClient});

  @override
  /// Retrieves a list of carousel items for the home screen.
  ///
  /// This method queries the Firestore database to get all documents from the
  /// "carousels" collection and converts them to [GetCarouselsResponse] models.
  ///
  /// Returns a list of [GetCarouselsResponse] containing the carousel data.
  Future<List<GetCarouselsResponse>> getCarousels() async {
    final response = await _fireStore.collection("carousels").get();

    return response.docs
        .map((e) => GetCarouselsResponse.fromJson(e.data()))
        .toList();
  }
}
