import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 48,
      width: 48,
      child: Column(
        children: [
          Icon(Icons.adjust_rounded, size: 36,color: Colors.blueAccent,),
          SizedBox(height: 2,),
          Text("Name")
        ],
      ),
    );
  }
}
