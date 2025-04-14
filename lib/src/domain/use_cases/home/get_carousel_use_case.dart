import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/home/carousel_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/home_repository.dart';

class GetCarouselUseCase {
  final HomeRepository homeRepository;

  GetCarouselUseCase({required this.homeRepository});

  Future<DataState<List<CarouselEntity>>> call() async {
    return await homeRepository.getCarousels();
  }
}
