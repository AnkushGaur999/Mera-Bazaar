import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/cart/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(GetCartItemsEvent());

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          buildWhen:
              (current, previous) =>
                  current is GetCartItemsLoading ||
                  current is GetCartItemsLoaded ||
                  current is GetCartItemsFailed,

          builder: (context, state) {

            if (state is GetCartItemsLoading || state is UpdateCartItemLoading) {
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

              int totalAmount = 0;
              int totalDiscount = 0;

              for(int i =0; i<state.cartItems.length; i++){
                totalAmount += state.cartItems[i].totalOriginalPrice!.toInt();
                totalDiscount  += state.cartItems[i].totalDiscountedPrice!.toInt();

                //state.cartItems[i].discountedPrice

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
                          'Subtotal: ₹1497',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Text(
                          'Delivery Charges: ₹50',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Discount: -₹250',
                          style: TextStyle(fontSize: 12.sp, color: Colors.green),
                        ),
                        const Divider(),
                        Text(
                          'Total: ₹1297',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ElevatedButton(
                          onPressed: () {},
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

                        SizedBox(height: 10.h,)

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
