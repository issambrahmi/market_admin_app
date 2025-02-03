import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class TrackingOrder extends StatelessWidget {
  const TrackingOrder({super.key, required this.status});

  final String status;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // waiting
            CircleAvatar(
              backgroundColor: status == 'waiting' ||
                      status == 'preparing' ||
                      status == 'finished'
                  ? AppColor.greencolor
                  : AppColor.mainScreencolor,
              maxRadius: 11.sp,
            ),
            Container(
              height: 5.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: status == 'preparing' || status == 'finished'
                    ? AppColor.greencolor
                    : AppColor.mainScreencolor,
              ),
            ),
            // preparing
            CircleAvatar(
              backgroundColor: status == 'preparing' || status == 'finished'
                  ? AppColor.greencolor
                  : AppColor.mainScreencolor,
              maxRadius: 11.sp,
            ),
            Container(
              height: 5.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: status == 'finished'
                    ? AppColor.greencolor
                    : AppColor.mainScreencolor,
              ),
            ),
            // finished
            CircleAvatar(
              backgroundColor: status == 'finished'
                  ? AppColor.greencolor
                  : AppColor.mainScreencolor,
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
                color:
                    status == 'waiting' ? Colors.black : Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 20.w),
            Text(
              'preparing',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color:
                    status == 'preparing' ? Colors.black : Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 20.w),
            Text(
              'finish',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color:
                    status == 'finished' ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ],
        )
      ],
    );
  }
}
