import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/home/carousel_entity.dart';

abstract class HomeRepository {
  Future<DataState<List<CarouselEntity>>> getCarousels();
}
