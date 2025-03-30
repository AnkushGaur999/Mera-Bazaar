import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: ClipRRect(

        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl:
              "https://img.freepik.com/free-photo/colorful-design-with-spiral-design_188544-9588.jpg?t=st=1743249572~exp=1743253172~hmac=2fc561650c43265cb2cd086d3ad405c9352e6d21c8f7d324a171b569d219872c&w=2000",
          fit: BoxFit.cover,
          width: MediaQuery.sizeOf(context).width/1.2,
        ),
      ),
    );
  }
}
