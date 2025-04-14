/// Interface for home data source operations.
///
/// This abstract class defines the contract for making home-related
/// API calls. It includes methods for:
/// - Retrieving carousel items
import 'package:mera_bazaar/src/data/models/home/get_carousels_response.dart';

/// Abstract class defining the contract for home data source operations.
///
/// This interface should be implemented by concrete classes that handle the actual
/// API calls for home screen operations. The methods return response models that
/// can be converted to domain entities.
abstract class HomeDataSource {
  /// Retrieves a list of carousel items for the home screen.
  ///
  /// This method should make an API call to get all carousel items.
  /// It returns a list of [GetCarouselsResponse] containing the carousel data.
  Future<List<GetCarouselsResponse>> getCarousels();
}
