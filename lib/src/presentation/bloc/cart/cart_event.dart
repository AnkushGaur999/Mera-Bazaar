part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {}

final class AddToCartEvent extends CartEvent {
  final CartEntity cartEntity;

  AddToCartEvent({required this.cartEntity});

  @override
  List<Object?> get props => [cartEntity];
}

final class GetCartItemsEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}

final class DeleteCartItemEvent extends CartEvent {
  final CartEntity cartEntity;
  DeleteCartItemEvent({required this.cartEntity});
  @override
  List<Object?> get props => [cartEntity];

}

final class UpdateCartItemEvent extends CartEvent {
  final CartEntity cartEntity;
  UpdateCartItemEvent({required this.cartEntity});
  @override
  List<Object?> get props => [cartEntity];
}
