import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/View/Users%20Page/add_newuseer_page.dart';
import 'package:market_admin_app/View/Users%20Page/commonW/users_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(
          () => const AddNewUserPage(),
        ),
        label: Text(
          'Add new user',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.greencolor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const AppTopSection(
              text: 'Users',
            ),
            SizedBox(height: 15.h),
            const UsersList()
          ],
        ),
      ),
    );
  }
}
