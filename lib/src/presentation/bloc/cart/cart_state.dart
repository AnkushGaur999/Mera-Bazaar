part of 'cart_bloc.dart';

sealed class CartState extends Equatable {}

final class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

final class AddToCartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

final class AddToCartLoaded extends CartState {
  final String message;

  AddToCartLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

final class AddToCartFailed extends CartState {
  final String message;

  AddToCartFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class GetCartItemsLoading extends CartState {
  @override
  List<Object?> get props => [];
}

final class GetCartItemsLoaded extends CartState {
  final List<CartEntity> cartItems;

  GetCartItemsLoaded({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}

final class GetCartItemsFailed extends CartState {
  final String message;

  GetCartItemsFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class DeleteCartItemLoading extends CartState {
  @override
  List<Object?> get props => [];
}

final class DeleteCartItemLoaded extends CartState {
  final String message;
  DeleteCartItemLoaded({required this.message});
  @override
  List<Object?> get props => [message];
}

final class DeleteCartItemFailed extends CartState {
  final String message;
  DeleteCartItemFailed({required this.message});
  @override
  List<Object?> get props => [message];
}

final class UpdateCartItemLoading extends CartState {
  @override
  List<Object?> get props => [];
}

final class UpdateCartItemLoaded extends CartState {
  final String message;

  UpdateCartItemLoaded({required this.message});

  @override
  List<Object?> get props => [message];

}

final class UpdateCartItemFailed extends CartState {
  final String message;
  UpdateCartItemFailed({required this.message});
  @override
  List<Object?> get props => [message];
}

