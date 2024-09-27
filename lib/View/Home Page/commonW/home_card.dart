import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:market_admin_app/Controller/home_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/View/Products%20Page/products_page.dart';
import 'package:market_admin_app/View/Users%20Page/users_page.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Get.to(() => const UsersPage());
          case 1:
            Get.to(() => const ProductsPage());
        }
      },
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColor.darkBlue.withOpacity(0.5),
              AppColor.greencolor.withOpacity(0.5),
            ]),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            Get.find<HomeController>().cards[index],
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
