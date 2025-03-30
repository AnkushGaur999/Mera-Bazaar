import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/widgets/app_search_bar.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/widgets/carousel_item.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/widgets/item_category.dart';
import 'package:mera_bazaar/src/presentation/pages/product/widgets/product_item.dart';

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

              CarouselSlider(
                options: CarouselOptions(
                  height: 160.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items:
                [1, 2, 3, 4, 5].map((item) => const CarouselItem()).toList(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [1, 2, 3, 4, 5].map((e) {
                  int index = [1, 2, 3, 4, 5].indexOf(e);
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
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 20.h),

              BlocBuilder<CategoryBloc, CategoryState>(
                bloc: BlocProvider.of<CategoryBloc>(context)
                  ..add(GetCategoriesEvent()),
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
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
                        shrinkWrap: false,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ItemCategory(
                            categoryEntity: state.categories[index],
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Popular Products",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                  children: [...List.generate(10, (index) =>
                      const AspectRatio(
                        aspectRatio: 1.0,
                        child: ProductItem(
                          imageUrl: "https://m.media-amazon.com/images/I/71Koe4yu2WL._AC_UF1000,1000_QL80_.jpg",
                          title: "Electronics",
                          price: 100.0,
                          rating: 4.5,
                        ),
                      ))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "New Arrival",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                  children: [...List.generate(10, (index) =>
                  const AspectRatio(
                    aspectRatio: 1.0,
                    child: ProductItem(
                      imageUrl: "https://m.media-amazon.com/images/I/71Koe4yu2WL._AC_UF1000,1000_QL80_.jpg",
                      title: "Electronics",
                      price: 100.0,
                      rating: 4.5,
                    ),
                  ))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Recommended Products",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                  children: [...List.generate(10, (index) =>
                  const AspectRatio(
                    aspectRatio: 1.0,
                    child: ProductItem(
                      imageUrl: "https://m.media-amazon.com/images/I/71Koe4yu2WL._AC_UF1000,1000_QL80_.jpg",
                      title: "Electronics",
                      price: 100.0,
                      rating: 4.5,
                    ),
                  ))
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
