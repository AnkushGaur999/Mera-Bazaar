import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';

class ItemCategory extends StatelessWidget {
  final CategoryEntity categoryEntity;

  const ItemCategory({super.key, required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0.sp),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: (){
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: categoryEntity.imageUrl!,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width/5.4.w,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.r),
          Text(categoryEntity.name!, style: TextStyle(fontSize: 10.sp),),
        ],
      ),
    );
  }
}
