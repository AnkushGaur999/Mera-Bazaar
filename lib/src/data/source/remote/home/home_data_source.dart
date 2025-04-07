import 'package:mera_bazaar/src/data/models/home/get_carousels_response.dart';

abstract class HomeDataSource {
  Future<List<GetCarouselsResponse>> getCarousels();
}
