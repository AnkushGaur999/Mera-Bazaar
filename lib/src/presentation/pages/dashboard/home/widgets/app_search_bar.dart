import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/core/constants/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColors.primaryColor),
                  SizedBox(width: 10.w),
                  const Expanded(child: Text("Search")),
                  Container(
                    height: double.infinity,
                    alignment: Alignment.centerRight,
                    width: 2,
                    color: Colors.grey.shade500,
                    margin: EdgeInsets.all(5.w),
                  ),

                  Icon(Icons.mic, color: AppColors.primaryColor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
