import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/app_color.dart';

class TrackingOrder extends StatelessWidget {
  const TrackingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColor.greencolor,
                maxRadius: 11.sp,
              ),
              Container(
                height: 5.h,
                width: 50.w,
                decoration: BoxDecoration(
                  //color: AppColor.mainScreencolor,
                  color: AppColor.greencolor,
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColor.greencolor,
                maxRadius: 11.sp,
              ),
              Container(
                height: 5.h,
                width: 50.w,
                decoration: const BoxDecoration(
                  color: AppColor.mainScreencolor,
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColor.mainScreencolor,
                maxRadius: 11.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Waiting',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: 20.w),
              Text(
                'preparing',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 20.w),
              Text(
                'finish',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
