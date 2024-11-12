import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/products_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_circle_indicator.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsController controller = Get.find<ProductsController>();
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
                        ? GetBuilder<ProductsController>(builder: (controller) {
                            return controller.products.isEmpty
                                ? const Center(child: Text('No users found'))
                                : ListView.separated(
                                    itemCount: controller.showSearchedUsers
                                        ? controller.searchedProducts.length + 1
                                        : controller.products.length + 1,
                                    controller: controller.scrollController,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 10.h),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return controller.showSearchedUsers
                                          ? index ==
                                                      controller
                                                          .searchedProducts
                                                          .length &&
                                                  !controller
                                                      .isMaxSearchedProducts &&
                                                  !controller
                                                      .isSearchNmaesShow.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : index ==
                                                          controller
                                                              .searchedProducts
                                                              .length &&
                                                      controller
                                                          .isMaxSearchedProducts
                                                  ? const SizedBox()
                                                  : ProductCard(index: index)
                                          : index ==
                                                      controller
                                                          .products.length &&
                                                  !controller.isMaxProducts &&
                                                  !controller
                                                      .isSearchNmaesShow.value
                                              ? Container(
                                                  padding:
                                                      EdgeInsets.all(10.sp),
                                                  height: 50.sp,
                                                  child: Center(
                                                    child: AppCircleIndicator(
                                                        size: 25.sp),
                                                  ),
                                                )
                                              : index ==
                                                          controller.products
                                                              .length &&
                                                      controller.isMaxProducts
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(10.sp),
                                                      height: 50.sp)
                                                  : ProductCard(index: index);
                                    });
                          })
                        : const SizedBox();
          })),
    );
  }
}
