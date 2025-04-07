import 'package:carousel_slider/carousel_slider.dart';
import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/widgets/app_search_bar.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/widgets/carousel_item.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/category/widgets/item_category.dart';
import 'package:mera_bazaar/src/presentation/pages/product/widgets/product_item.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  int _current = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CategoryBloc>().add(GetCategoriesEvent());
    context.read<HomeBloc>().add(GetCarouselsEvent());
    context.read<ProductBloc>().add(GetProductsEvent(type: "famous"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              const AppSearchBar(),

              SizedBox(height: 16.h),

              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is GetCarouselLoading) {
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
                  }

                  if (state is GetCarouselLoaded) {
                    return Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 160.h,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            viewportFraction: 1,
                            aspectRatio: 16 / 9,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          items:
                          state.carousels
                              .map(
                                (item) =>
                                CarouselItem(imageUrl: item.imageUrl!),
                          )
                              .toList(),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          state.carousels.map((e) {
                            int index = state.carousels.indexOf(e);
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 2,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                _current == index
                                    ? const Color.fromRGBO(0, 0, 0, 0.9)
                                    : const Color.fromRGBO(
                                  0,
                                  0,
                                  0,
                                  0.4,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }

                  return SizedBox(height: 100.h);
                },
              ),

              SizedBox(height: 20.h),

              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return SizedBox(
                      height:
                      MediaQuery
                          .of(context)
                          .orientation ==
                          Orientation.portrait
                          ? 80.h
                          : 60.w,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return const ItemCategory(
                            categoryEntity: null,
                            isLoading: true,
                          );
                        },
                      ),
                    );
                  } else if (state is CategoryFailed) {
                    return Center(child: Text(state.message));
                  } else if (state is CategoryLoaded) {
                    return SizedBox(
                      height:
                      MediaQuery
                          .of(context)
                          .orientation ==
                          Orientation.portrait
                          ? 80.h
                          : 60.w,
                      child: ListView.builder(
                        itemCount: state.categories.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ItemCategory(
                            categoryEntity: state.categories[index],
                            isLoading: false,
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),

              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is GetProductsLoading) {
                    return SizedBox(
                      height: 110.h,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [1,2,3,4,5].map((e)=> Padding(
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
                            ),),
                        )).toList(),
                      ),
                    );
                  }

                  if (state is GetProductsLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Famous Products",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text("View All"),
                              ),
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
                                  (product) =>
                                  AspectRatio(
                                    aspectRatio: 1.0,
                                    child: ProductItem(
                                      productEntity: product,
                                    ),
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
