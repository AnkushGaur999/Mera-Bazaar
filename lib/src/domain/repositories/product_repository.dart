import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart';

abstract class ProductRepository{

  Future<DataState<List<ProductEntity>>> getProducts({required String categoryId});

}