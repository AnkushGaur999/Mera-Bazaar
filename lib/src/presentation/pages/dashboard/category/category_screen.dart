import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/presentation/bloc/category/category_bloc.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/widgets/item_category.dart';
import 'package:mera_bazaar/src/presentation/pages/product/widgets/product_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),

      body: Row(
        children: [
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
                  width:80.w,
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
            child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return const ProductItem(
                  imageUrl: "https://m.media-amazon.com/images/I/71Koe4yu2WL._AC_UF1000,1000_QL80_.jpg",
                  title: "Electronics",
                  price: 100.0,
                  rating: 4.5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
