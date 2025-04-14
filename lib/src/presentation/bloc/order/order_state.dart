part of 'order_bloc.dart';

sealed class OrderState extends Equatable {}

final class InitialOrderState extends OrderState{

  @override
  List<Object?> get props => [];
}

final class GetOrdersHistoryLoading extends OrderState {
  @override
  List<Object?> get props => [];
}

final class GetOrdersHistoryLoaded extends OrderState {
  final List<OrderEntity> orders;

  GetOrdersHistoryLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

final class GetOrderHistoryFailed extends OrderState {
  final String message;

  GetOrderHistoryFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
