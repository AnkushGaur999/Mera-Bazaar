part of 'product_bloc.dart';

sealed class ProductState extends Equatable {}

final class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

final class GetProductsLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

final class GetProductsLoaded extends ProductState {
  final List<ProductEntity> products;

  GetProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

final class GetProductsFailed extends ProductState {
  final String message;

  GetProductsFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
