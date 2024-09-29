import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:market_admin_app/Controller/home_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<HomeController>().onTap(index),
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
