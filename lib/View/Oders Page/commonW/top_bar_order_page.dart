import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/order_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class TopBarOrderPage extends StatelessWidget {
  const TopBarOrderPage({super.key, required this.onBackTap});

  final void Function() onBackTap;
  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.find<OrderController>();
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.greencolor,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Stack(
                children: [
                  IconButton(
                      onPressed: onBackTap,
                      style: IconButton.styleFrom(
                        backgroundColor: AppColor.mainScreencolor,
                      ),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black45,
                      )),
                  Center(
                    child: Text(
                      'Orders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () =>
                          controller.switchBetweenNewAndAcceptedOrders(false),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: !controller.isAccepted.value
                              ? Border(
                                  bottom: BorderSide(
                                      color: AppColor.darkBlue, width: 3))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'New',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: !controller.isAccepted.value
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          controller.switchBetweenNewAndAcceptedOrders(true),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: controller.isAccepted.value
                              ? Border(
                                  bottom: BorderSide(
                                      color: AppColor.darkBlue, width: 3))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Accepted',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: controller.isAccepted.value
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
