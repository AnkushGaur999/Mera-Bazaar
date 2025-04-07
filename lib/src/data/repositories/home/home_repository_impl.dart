import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/home/home_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/home/carousel_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl({required this.homeDataSource});

  @override
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
