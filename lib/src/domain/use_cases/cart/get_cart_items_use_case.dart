import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository cartRepository;

  GetCartItemsUseCase({required this.cartRepository});

  Future<DataState<List<CartEntity>>> call() async {
    return await cartRepository.getCartItems();
  }
}
