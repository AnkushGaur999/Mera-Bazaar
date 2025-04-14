
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/product_repository.dart';

class GetProductsUseCase{
  final ProductRepository productRepository;

  GetProductsUseCase({required this.productRepository});

  Future<DataState<List<ProductEntity>>> call({required String categoryId}) async{
    return await productRepository.getProducts(categoryId: categoryId);
  }

}