import 'package:equatable/equatable.dart';
import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/order/order_entity.dart';
import 'package:mera_bazaar/src/domain/use_cases/order/get_orders_history_use_case.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersHistoryUseCase getOrdersHistoryUseCase;

  OrderBloc({required this.getOrdersHistoryUseCase})
    : super(InitialOrderState()) {
    on<GetOrdersHistoryEvent>(_getOrders);
    add(GetOrdersHistoryEvent());
  }

  void _getOrders(GetOrdersHistoryEvent event, Emitter<OrderState> emit) async {
    emit(GetOrdersHistoryLoading());
    final response = await getOrdersHistoryUseCase.call();

    if (response is DataSuccess) {
      emit(GetOrdersHistoryLoaded(orders: response.data!));
    } else {
      emit(GetOrderHistoryFailed(message: response.exception!.message));
    }
  }
}
