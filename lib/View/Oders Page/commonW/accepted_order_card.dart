import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/order_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_alert_dialogue.dart';
import 'package:market_admin_app/Model/Models/order_model.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/tracking_order.dart';
import 'package:market_admin_app/View/Oders%20Page/orders_detailes_page.dart';

class AcceptedOrderCard extends StatelessWidget {
  const AcceptedOrderCard(
      {super.key, required this.order, required this.index, this.isSearched});

  final OrderModel order;
  final int index;
  final bool? isSearched;
  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.find<OrderController>();
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.mainScreencolor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TrackingOrder(
                status: order.status,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Order Id : ',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
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
                    onTap: () {
                      FlutterClipboard.copy(order.id.toString()).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Order ID copied to clipboard!')),
                        );
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColor.greencolorWithOpacity05,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          'copy',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(
                    'Client name : ',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      order.clientName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(
                    'Worker name : ',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      order.workerName.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
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
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
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
                    '${order.totalePrice.toString()} Da',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              // AppButton(
              //   text: 'View Order Detailes',
              //   height: 40.h,
              //   width: double.infinity,
              //   textSize: 15.sp,
              //   textColor: Colors.white,
              //   color: AppColor.darkBlue,
              //   onTap: () {
              //     controller.orderIndex = index;
              //     Get.to(() => const OrdersDetailesPage());
              //     controller.getOrderItems(order.id, index);
              //   },
              // ),
            ],
          ),
        ),
        // 3 dots
        Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<String>(
            onSelected: (value) {
              // Perform actions based on the selected value
              if (value == 'details') {
                controller.orderIndex = index;
                Get.to(() => const OrdersDetailesPage());
                controller.getOrderItems(order.id, index, isSearched ?? false);
              }
              if (value == 'delete') {
                appAlertDialogue(
                    context: context,
                    text: 'Are u sure u want to delete this order ?',
                    height: 20.h,
                    onTap: () {
                      {}
                    });
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'details',
                  child: Text('View more details'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
