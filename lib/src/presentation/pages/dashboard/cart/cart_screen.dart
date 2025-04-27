import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/cart/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: SafeArea(
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is DeleteCartItemLoaded ||
                state is UpdateCartItemLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item successfully updated")),
              );
              context.read<CartBloc>().add(GetCartItemsEvent());
            }
          },
          buildWhen:
              (current, previous) =>
                  current is GetCartItemsLoading ||
                  current is GetCartItemsLoaded ||
                  current is GetCartItemsFailed,

          builder: (context, state) {
            if (state is GetCartItemsLoading ||
                state is UpdateCartItemLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetCartItemsLoaded) {
              if (state.cartItems.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Icon(Icons.add_shopping_cart, size: 48),
                    ],
                  ),
                );
              }

              double totalItemsPrice = 0;
              double totalDiscountedPrice = 0;
              double totalPriceAfterDiscount = 0;

              for (int i = 0; i < state.cartItems.length; i++) {
                totalItemsPrice += state.cartItems[i].totalOriginalPrice!;
                totalDiscountedPrice +=
                    state.cartItems[i].totalOriginalPrice! -
                    state.cartItems[i].totalDiscountedPrice!;

                totalPriceAfterDiscount +=
                    state.cartItems[i].totalDiscountedPrice!;
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          cartEntity: state.cartItems[index],
                          onDelete:
                              () => context.read<CartBloc>().add(
                                DeleteCartItemEvent(
                                  cartEntity: state.cartItems[index],
                                ),
                              ),
                          onIncrement: () {
                            final item = state.cartItems[index];

                            item.quantity = item.quantity! + 1;
                            item.totalOriginalPrice =
                                item.originalPrice! * item.quantity!;
                            item.totalDiscountedPrice =
                                item.discountedPrice! * item.quantity!;
                            context.read<CartBloc>().add(
                              UpdateCartItemEvent(cartEntity: item),
                            );
                          },

                          onDecrement: () {
                            final item = state.cartItems[index];

                            item.quantity = item.quantity! - 1;
                            item.totalOriginalPrice =
                                item.originalPrice! / item.quantity!;
                            item.totalDiscountedPrice =
                                item.discountedPrice! / item.quantity!;
                            context.read<CartBloc>().add(
                              UpdateCartItemEvent(cartEntity: item),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Subtotal: \$$totalItemsPrice',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Text(
                          'Delivery Charges: \$50',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Discount: -\$$totalDiscountedPrice',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.green,
                          ),
                        ),
                        const Divider(),
                        Text(
                          'Total: \$$totalPriceAfterDiscount',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ElevatedButton(
                          onPressed: () => context.pushNamed(AppRoutes.payment),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 8.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
