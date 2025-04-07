
part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable{}

final class GetProductsEvent extends ProductEvent{
  final String type;
  GetProductsEvent({required this.type});

  @override
  List<Object?> get props => [type];

}

