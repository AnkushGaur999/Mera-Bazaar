import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/category/widgets/item_category.dart';
import 'package:mera_bazaar/src/presentation/pages/product/widgets/product_item.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(GetCategoriesEvent());
    context.read<ProductBloc>().add(GetProductsEvent(type: "famous"));

    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return SizedBox(
                  width: 80.w,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 60.w,
                          height: 60.h,
                          margin: EdgeInsets.all(8.0.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is CategoryFailed) {
                return Center(child: Text(state.message));
              } else if (state is CategoryLoaded) {
                return SizedBox(
                  width: 80.w,
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 80.h,
                        child: ItemCategory(
                          categoryEntity: state.categories[index],
                          isLoading: false,
                          onTap: () {
                            context.read<ProductBloc>().add(
                              GetProductsEvent(
                                type: state.categories[index].name!,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),

          const VerticalDivider(color: Colors.grey, thickness: 2),

          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {

                if(state is GetProductsLoading){
                  return  GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 20,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 280.w,
                          height: 160.h,
                          margin: EdgeInsets.all(8.0.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }

                if (state is GetProductsLoaded) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ProductItem(productEntity: state.products[index]);
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
