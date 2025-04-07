import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/cart_repository.dart';

class DeleteCartItemUseCase {
  final CartRepository repository;

  DeleteCartItemUseCase({required this.repository});

  Future<DataState<String>> call({required CartEntity cartEntity}) async {
    return await repository.deleteCartItem(id: cartEntity.id!);
  }
}
