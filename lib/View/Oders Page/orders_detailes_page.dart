import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/order_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_circle_indicator.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/order_d_bottom_sect.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/order_detaille_products.dart';

class OrdersDetailesPage extends StatelessWidget {
  const OrdersDetailesPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.find<OrderController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopSection(text: 'Order detaille'),
            SizedBox(height: 10.h),
            Expanded(
                child: Obx(() =>
                    controller.orderDetaillesState.value == RequestEnum.waiting
                        ? AppCircleIndicator(size: 30.sp)
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: const OrderDetailesProducts(),
                          ))),
            Obx(() =>
                controller.orderDetaillesState.value == RequestEnum.successes
                    ? OrderDetailesDownSec(
                        totalPrice: (controller.isAccepted.value
                            ? controller.acceptedOrders[controller.orderIndex]
                                .totalePrice
                            : controller
                                .newOrders[controller.orderIndex].totalePrice),
                      )
                    : const SizedBox())
          ],
        ),
      ),
    );
  }
}
