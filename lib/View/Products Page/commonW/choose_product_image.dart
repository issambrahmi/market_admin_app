import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/products_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class ChooseProductImage extends StatelessWidget {
  const ChooseProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ProductsController>();
    return SizedBox(
      height: 80.sp,
      width: 80.sp,
      child: Stack(
        children: [
          GetBuilder<ProductsController>(builder: (controller) {
            return GestureDetector(
              onTap: () => controller.pickImage(),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: controller.productPic == null
                      ? Image.asset(
                          'assets/images/person.png',
                        )
                      : Image.file(
                          File(controller.productPic!.path),
                          fit: BoxFit.cover,
                          width: 80.sp,
                          height: 80.sp,
                        )),
            );
          }),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
              child: GetBuilder<ProductsController>(builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.productPic != null) {
                      controller.productPic = null;
                      controller.update();
                    } else {
                      controller.pickImage();
                    }
                  },
                  child: Icon(
                    controller.productPic == null
                        ? Icons.add_circle_outline_outlined
                        : Icons.delete,
                    size: 22.sp,
                    color: controller.productPic == null
                        ? AppColor.greencolor
                        : AppColor.deleteColor,
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
