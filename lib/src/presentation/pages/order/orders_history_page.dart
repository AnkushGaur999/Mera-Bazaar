import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/presentation/bloc/order/order_bloc.dart';
import 'package:mera_bazaar/src/presentation/pages/order/widgets/order_item.dart';

class OrdersHistoryPage extends StatelessWidget {
  const OrdersHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders History'), elevation: 0),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is GetOrdersHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetOrdersHistoryLoaded) {


            return ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return OrderItem(order: state.orders[index]);
              },
            );
          } else if (state is GetOrderHistoryFailed) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
