import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text('Account'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://media.licdn.com/dms/image/v2/C5103AQFtR8T9MiVxiA/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1581317796036?e=1749081600&v=beta&t=sAEPtNJ-V21UI2blGaF3pglAFwTxwouk1omQVMwCFqc',
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Text(
                        'Ankush Gaur',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              Text(
                "General",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),

              _buildListTile(Icons.person, 'Profile', () {}),
              _buildListTile(Icons.shopping_bag, 'Orders', () {}),
              _buildListTile(Icons.favorite, 'Wishlist', () {}),
              _buildListTile(Icons.notifications, 'Notifications', () {}),
              _buildListTile(Icons.language, 'Language', () {}),
              _buildListTile(Icons.location_on, 'Shipping Address', () {}),

              SizedBox(height: 10.h),

              Text(
                "Preferences",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              _buildListTile(Icons.policy, 'Legal & Policies', () {}),
              _buildListTile(Icons.help, 'Help & Support', () {}),
              _buildListTile(Icons.info, 'About Us', () {}),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 16.w),
            Text(title, style: TextStyle(color: Colors.black, fontSize: 14.sp)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
