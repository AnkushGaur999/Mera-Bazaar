import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/domain/use_cases/product/get_products_use_case.dart';
import 'package:mera_bazaar/src/presentation/pages/product/widgets/product_item.dart';
import 'package:shimmer/shimmer.dart';

class HomeProductItem extends StatelessWidget {
  final String title;
  final String id;

  const HomeProductItem({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: ProductBloc(getProductsUseCase: getIt<GetProductsUseCase>())
        ..add(GetProductsEvent(categoryId: "YsXVA7X1EgWrpUWvpf8f")),
      builder: (context, state) {
        if (state is GetProductsLoading) {
          return SizedBox(
            height: 110.h,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children:
                  [1, 2, 3, 4, 5]
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width / 3.2.w,
                              height: 100.h,
                              margin: EdgeInsets.all(2.0.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          );
        }

        if (state is GetProductsLoaded) {
          if (state.products.isEmpty) {
            return const SizedBox();
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text("View All")),
                  ],
                ),
              ),

              SizedBox(
                height: 110.h,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children:
                      state.products
                          .map(
                            (product) => AspectRatio(
                              aspectRatio: 1.0,
                              child: ProductItem(productEntity: product),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
