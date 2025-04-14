import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/cart_repository.dart';

class UpdateCartItemUseCase {
  final CartRepository repository;

  UpdateCartItemUseCase({required this.repository});

  Future<DataState<String>> call({required CartEntity cartEntity}) async {
    return await repository.updateCartItem(cartEntity: cartEntity);
  }
}
