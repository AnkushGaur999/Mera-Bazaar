
part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable{}

final class GetProductsEvent extends ProductEvent{
  final String categoryId;
  GetProductsEvent({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];

}

