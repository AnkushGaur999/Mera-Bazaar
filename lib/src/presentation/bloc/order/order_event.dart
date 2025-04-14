
part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable{
}

final class GetOrdersHistoryEvent extends OrderEvent{

  @override
  List<Object?> get props => [];

}

