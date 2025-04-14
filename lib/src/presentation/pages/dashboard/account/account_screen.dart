 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mera_bazaar/src/config/route/app_routes.dart';
import 'package:mera_bazaar/src/presentation/bloc/authentication/auth_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(
      GetUserProfileEvent(token: "YKaxiSO1NagMEQA7jN5t"),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Account'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Center(
                      child: BlocBuilder<AuthBloc, AuthState>(
                        buildWhen:
                            (previous, current) =>
                                current is GetUserProfileLoading ||
                                current is GetUserProfileSuccess ||
                                current is GetUserProfileError,
                        builder: (context, state) {

                          if (state is GetUserProfileLoading) {
                            return SizedBox(height: 100.h);
                          }

                          if (state is GetUserProfileSuccess) {
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    state.userData.imageUrl!,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  state.userData.name!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
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
              _buildListTile(Icons.shopping_bag, 'Orders', () => context.pushNamed(AppRoutes.orderHistory)),
              _buildListTile(Icons.favorite, 'Wishlist', () {}),
              _buildListTile(
                Icons.notifications,
                'Notifications',
                () => context.pushNamed(AppRoutes.notification),
              ),
              _buildListTile(Icons.language, 'Language', () {}),

              _buildListTile(Icons.location_on, 'Shipping Address', () {}),

              _buildListTile(
                Icons.color_lens_rounded,
                'Theme',
                () => context.pushNamed(AppRoutes.themeUpdate),
              ),

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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 16.w),
            Text(title, style: TextStyle(fontSize: 14.sp)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
