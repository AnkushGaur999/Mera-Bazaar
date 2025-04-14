/// Implementation of the home repository.
///
/// This class implements the [HomeRepository] interface and provides
/// concrete implementations for home-related data operations. It acts as a
/// mediator between the data source and the domain layer, handling data
/// transformation and error handling.
import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/home/home_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/home/carousel_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/home_repository.dart';

/// A concrete implementation of the [HomeRepository] interface.
///
/// This class handles the retrieval and transformation of home-related data,
/// such as carousel items. It uses a [HomeDataSource] to fetch raw data and
/// converts it to domain entities.
class HomeRepositoryImpl extends HomeRepository {
  /// The data source for home-related operations
  final HomeDataSource homeDataSource;

  /// Creates a new instance of [HomeRepositoryImpl].
  ///
  /// Requires a [HomeDataSource] to be provided for fetching home-related data.
  HomeRepositoryImpl({required this.homeDataSource});

  @override
  /// Retrieves a list of carousel items.
  ///
  /// This method fetches carousel data from the data source and transforms
  /// it into domain entities. It handles network errors and other exceptions
  /// by wrapping them in appropriate [NetworkException] instances.
  ///
  /// Returns a [DataState] containing either:
  /// - A list of [CarouselEntity] objects on success
  /// - A [NetworkException] on failure
  Future<DataState<List<CarouselEntity>>> getCarousels() async {
    try {
      final response = await homeDataSource.getCarousels();
      return DataSuccess(data: response.map((e) => e.toEntity(e)).toList());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }
}
