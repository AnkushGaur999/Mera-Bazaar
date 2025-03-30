import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://m.media-amazon.com/images/I/71Koe4yu2WL._AC_UF1000,1000_QL80_.jpg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product Name',
                                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                    ),

                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Text(
                                          '₹499',
                                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 8.h),
                                        Text(
                                          '₹999',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: 8.h),
                                        Text(
                                          '50% OFF',
                                          style: TextStyle(fontSize: 12.sp, color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Delivery by: Apr 5, 2025',
                                      style: TextStyle(fontSize: 10.sp, color: Colors.grey[700]),
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(2),
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                          ),
                                          onPressed: () {},
                                          child: const Icon(Icons.remove, color: Colors.blue, size: 20,),
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(2),
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                          ),
                                          onPressed: () {},
                                          child: const Icon(Icons.add, color: Colors.blue, size: 20,),

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20,),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Item removed from cart'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Subtotal: ₹1497',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Text(
                    'Delivery Charges: ₹50',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                  ),
                  Text(
                    'Discount: -₹250',
                    style: TextStyle(fontSize: 12.sp, color: Colors.green),
                  ),
                  const Divider(),
                  Text(
                    'Total: ₹1297',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Checkout', style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
