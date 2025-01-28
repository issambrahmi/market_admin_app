import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/order_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_alert_dialogue.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_circle_indicator.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_drop_down.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/Model/Models/order_model.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/accept_order_dialogue.dart';
import 'package:market_admin_app/View/Oders%20Page/orders_detailes_page.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.index});

  final OrderModel order;
  final int index;
  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.find<OrderController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.mainScreencolor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const TrackingOrder(),
          // SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Order Id : ',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    order.id.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  child: Icon(
                    Icons.delete,
                    color: AppColor.deleteColor,
                    size: 25.sp,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            order.date.toString(),
            //  'Mar 21, 1.25Pm',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text(
                'Items : ',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.w),
              Text(
                '25',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Totale : ',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.w),
              Text(
                '${order.totalePrice.toString()} Da',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          AppButton(
            text: 'Accept Order',
            height: 40.h,
            width: double.infinity,
            textSize: 15.sp,
            textColor: Colors.white,
            color: AppColor.greencolor,
            onTap: () {
              controller.getWorkers();
              acceptOrderDialogue(context: context, orderIndex: index);
            },
          ),
          SizedBox(height: 10.h),
          AppButton(
            text: 'View Order Detailes',
            height: 40.h,
            width: double.infinity,
            textSize: 15.sp,
            textColor: Colors.white,
            color: AppColor.darkBlue,
            onTap: () {
              controller.orderIndex = index;
              Get.to(() => const OrdersDetailesPage());
              controller.getOrderItems(order.id, index);
            },
          ),
        ],
      ),
    );
  }
}
