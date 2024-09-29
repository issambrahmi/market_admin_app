import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/Shared%20Widgets/app_button.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/tracking_order.dart';
import 'package:market_admin_app/View/Oders%20Page/orders_detailes_page.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.delete,
                size: 20.sp,
                color: AppColor.deleteColor,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          //height: 200.h,
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TrackingOrder(),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    'Order Id : ',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'W35THW: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                'Mar 21, 1.25Pm',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(
                    'Totale : ',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '27000 Da',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              AppButton(
                text: 'View Order Detailes',
                height: 40.h,
                width: double.infinity,
                textSize: 15.sp,
                color: AppColor.greencolor,
                onTap: () {
                  Get.to(() => const OrdersDetailesPage());
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
