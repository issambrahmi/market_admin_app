import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/order_controller.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/accepted_order_card.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/new_order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.find<OrderController>();
    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(() {
            return controller.reqState.value == RequestEnum.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.reqState.value == RequestEnum.serverError
                    ? const Center(
                        child: Text('Server err'),
                      )
                    : controller.reqState.value == RequestEnum.successes
                        ? Obx(() => (controller.isAccepted.value &&
                                    controller.acceptedOrders.isEmpty) ||
                                (!controller.isAccepted.value &&
                                    controller.newOrders.isEmpty)
                            ? const Center(child: Text('No orders found'))
                            : GetBuilder<OrderController>(
                                builder: (controller) => ListView.separated(
                                      itemCount: controller.isAccepted.value
                                          ? controller.acceptedOrders.length
                                          : controller.newOrders.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 10.h),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return controller.isAccepted.value
                                            ? AcceptedOrderCard(
                                                index: index,
                                                order: controller
                                                    .acceptedOrders[index])
                                            : NewOrderCard(
                                                index: index,
                                                order: controller
                                                    .newOrders[index]);
                                      },
                                    )))
                        : const SizedBox();
          })),
    );
  }
}
