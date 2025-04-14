import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'package:shimmer/shimmer.dart';

class ItemCategory extends StatelessWidget {
  final CategoryEntity? categoryEntity;
  final bool isLoading;
  final VoidCallback? onTap;
  final String? selectedId;

  const ItemCategory({
    super.key,
    required this.isLoading,
    this.categoryEntity,
    this.onTap,
    this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child:
          isLoading
              ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 5.4.w,
                  height: 60.h,
                  margin: EdgeInsets.all(2.0.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                selectedId == categoryEntity!.id
                                    ? Border.all(color: Colors.green, width: 3)
                                    : null,
                            // border color and width
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ), // must match ClipRRect radius
                          ),
                          child: CachedNetworkImage(
                            imageUrl: categoryEntity!.imageUrl!,
                            fit: BoxFit.cover,
                            width: MediaQuery.sizeOf(context).width / 5.4.w,
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.r),
                  Text(
                    categoryEntity!.name!,
                    style: TextStyle(fontSize: 10.sp),
                  ),
                ],
              ),
    );
  }
}
