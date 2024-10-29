import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class AppTopSection extends StatelessWidget {
  const AppTopSection({super.key, required this.text, this.isHome});
  final String text;
  final bool? isHome;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.greencolor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      child: isHome == true
          ? Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColor.mainScreencolor,
                      ),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black45,
                      )),
                  Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
