
import 'package:mera_bazaar/src/data/models/product/products_response.dart';

abstract class ProductDataSource{

  Future<List<ProductResponse>> getProducts({required String type});

}