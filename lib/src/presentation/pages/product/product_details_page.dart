import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double rating;
  final String description;

  const ProductDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
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
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 20),
                    SizedBox(width: 4.w),
                    Text(
                      rating.toString(),
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
              description,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
