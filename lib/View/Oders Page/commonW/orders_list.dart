import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/order_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_circle_indicator.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/Model/Models/order_model.dart';
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
                        ? Obx(() => ((controller.isAccepted.value &&
                                    controller.acceptedOrders.isEmpty) ||
                                (!controller.isAccepted.value &&
                                    controller.newOrders.isEmpty)) && !controller.isSearched.value
                            ? const Center(child: Text('No orders found'))
                            : GetBuilder<OrderController>(
                                builder: (controller) =>
                                    // show search order
                                    controller.isSearched.value &&
                                            controller.searchedOrder != null
                                        ? ListView.builder(
                                            itemCount:
                                                controller.searchedOrder == null
                                                    ? 0
                                                    : 1,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                controller.searchedOrder!
                                                            .workerName !=
                                                        null
                                                    ? AcceptedOrderCard(
                                                        order: controller
                                                                .searchedOrder
                                                            as OrderModel,
                                                        index: 0,
                                                        isSearched: true,
                                                      )
                                                    : NewOrderCard(
                                                        order: controller
                                                                .searchedOrder
                                                            as OrderModel,
                                                        index: 0,
                                                        isSearched: true,
                                                      ))

                                        // if there is no order with search id
                                        : controller.isSearched.value &&
                                                controller.searchedOrder == null
                                            ? const Center(
                                                child: Text(
                                                    'There is No Order with this id'),
                                              )
                                            // show list of orders
                                            : ListView.separated(
                                                itemCount:
                                                    //test if we are in AcceptedOrders
                                                    controller.isAccepted.value
                                                        //test if max acceptedOrders to not show circleIndicator
                                                        ? controller
                                                                .isMaxAcceptedOrders
                                                            ? controller
                                                                    .acceptedOrders
                                                                    .length +
                                                                1
                                                            : controller
                                                                .acceptedOrders
                                                                .length
                                                        //test if we are in newOrders
                                                        : controller
                                                                .isMaxNewOrders
                                                            //test if not max newOrders to not show circleIndicator
                                                            ? controller
                                                                    .newOrders
                                                                    .length +
                                                                1
                                                            : controller
                                                                .newOrders
                                                                .length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(height: 10.h),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  // show circleIndictor if not max yet
                                                  return
                                                      //test if AcceptedOrders not max and last index
                                                      (controller.isAccepted
                                                                      .value &&
                                                                  !controller
                                                                      .isMaxAcceptedOrders &&
                                                                  index ==
                                                                      controller
                                                                          .acceptedOrders
                                                                          .length) ||
                                                              //test if newOrders not max and last index
                                                              (!controller
                                                                      .isAccepted
                                                                      .value &&
                                                                  !controller
                                                                      .isMaxNewOrders &&
                                                                  index ==
                                                                      controller
                                                                          .newOrders
                                                                          .length)
                                                          ? AppCircleIndicator(
                                                              size: 30.sp)
                                                          // if isMax True show nothing
                                                          : (controller.isAccepted.value &&
                                                                      controller
                                                                          .isMaxAcceptedOrders &&
                                                                      index ==
                                                                          controller
                                                                              .acceptedOrders
                                                                              .length) ||
                                                                  (!controller
                                                                          .isAccepted
                                                                          .value &&
                                                                      controller
                                                                          .isMaxNewOrders &&
                                                                      index ==
                                                                          controller
                                                                              .newOrders
                                                                              .length)
                                                              ? const SizedBox()
                                                              // if not max or max and not last index show Card
                                                              : controller
                                                                      .isAccepted
                                                                      .value
                                                                  ? AcceptedOrderCard(
                                                                      index:
                                                                          index,
                                                                      order: controller.acceptedOrders[
                                                                          index])
                                                                  : NewOrderCard(
                                                                      index:
                                                                          index,
                                                                      order:
                                                                          controller.newOrders[index]);
                                                },
                                              )))
                        : const SizedBox();
          })),
    );
  }
}
