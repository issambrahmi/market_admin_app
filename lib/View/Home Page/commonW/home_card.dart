import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/app_color.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColor.darkBlue.withOpacity(0.5),
            AppColor.greencolor.withOpacity(0.5),
          ]),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          'Add New User',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
