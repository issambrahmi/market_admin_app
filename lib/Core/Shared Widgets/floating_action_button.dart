import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton(
      {super.key, required this.onTap, required this.text});
  final Function() onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      label: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColor.greencolor,
    );
  }
}
