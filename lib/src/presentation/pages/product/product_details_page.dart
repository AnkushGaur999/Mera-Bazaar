import 'dart:math';
import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDetailsScreen({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productEntity.name!)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        productEntity.imageUrl!,
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                            Center(child: Icon(
                                Icons.error_outline_rounded, size: 200.h)),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      productEntity.name!,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${productEntity.price?.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              productEntity.rating.toString(),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Product Description',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "This is description",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is AddToCartLoaded) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    context.pushNamed(AppRoutes.cart);
                  }

                  if (state is AddToCartFailed) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is AddToCartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(240.w, 40.h)),
                    onPressed: () {
                      final cartEntity = CartEntity(
                        id: Random.secure().nextInt(10000),
                        name: productEntity.name,
                        imageUrl: productEntity.imageUrl,
                        price: productEntity.price,
                        quantity: 1,
                        discount: productEntity.discount,
                        rating: productEntity.rating,
                        discountedPrice: productEntity.discountedPrice,
                        originalPrice: productEntity.originalPrice,
                        totalOriginalPrice: productEntity.originalPrice,
                        totalDiscountedPrice: productEntity.discountedPrice,
                      );

                      context.read<CartBloc>().add(
                        AddToCartEvent(cartEntity: cartEntity),
                      );
                    },
                    child: const Text("Add To Cart"),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
