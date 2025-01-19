import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/order_d_product_card.dart';

import '../../../Controller/order_controller.dart';

class OrderDetailesProducts extends StatelessWidget {
  const OrderDetailesProducts({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.find<OrderController>();

    return ListView.separated(
      //physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.isAccepted.value
          ? controller.acceptedOrders[controller.orderIndex].orderItems.length
          : controller.newOrders[controller.orderIndex].orderItems.length,
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemBuilder: (BuildContext context, int index) {
        return ProductCardProductDetailes(
          item: controller.isAccepted.value
              ? controller
                  .acceptedOrders[controller.orderIndex].orderItems[index]
              : controller.newOrders[controller.orderIndex].orderItems[index],
        );
      },
    );
  }
}
