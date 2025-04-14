import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/domain/use_cases/product/get_products_use_case.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/category/widgets/item_category.dart';
import 'package:mera_bazaar/src/presentation/pages/product/widgets/product_item.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryId;

  const CategoryScreen({super.key, this.categoryId = "YsXVA7X1EgWrpUWvpf8f"});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _categoryScrollController = ScrollController();
  late String categoryId;

  final double _itemHeight = 60.0;

  @override
  void initState() {
    super.initState();
    categoryId = widget.categoryId;
  }

  void _scrollToIndex(int index) {
    _categoryScrollController.animateTo(
      index * _itemHeight,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CategoryBloc>().add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
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
                state.categories.map((category) {
                  if (category.id == categoryId) {
                    _scrollToIndex(state.categories.indexOf(category));
                  }
                });
                return SizedBox(
                  width: 80.w,
                  child: ListView.builder(
                    controller: _categoryScrollController,
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
                          selectedId: categoryId,
                          onTap: () {
                            setState(() {
                              categoryId = state.categories[index].id!;
                            });
                            context.read<ProductBloc>().add(
                              GetProductsEvent(
                                categoryId: "${state.categories[index].id}",
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
              bloc: ProductBloc(getProductsUseCase: getIt<GetProductsUseCase>())
                ..add(GetProductsEvent(categoryId: categoryId)),
              builder: (context, state) {
                if (state is GetProductsLoading) {
                  return GridView.builder(
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
                  if (state.products.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No items Available.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(Icons.remove_shopping_cart_rounded, size: 48),
                        ],
                      ),
                    );
                  }

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
