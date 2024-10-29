import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class ChooseUserImage extends StatelessWidget {
  const ChooseUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<UsersController>();
    return SizedBox(
      height: 80.sp,
      width: 80.sp,
      child: Stack(
        children: [
          GetBuilder<UsersController>(builder: (controller) {
            return GestureDetector(
              onTap: () => controller.pickImage(),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: controller.userPic == null
                      ? Image.asset(
                          'assets/images/person.png',
                        )
                      : Image.file(
                          File(controller.userPic!.path),
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
              child: GetBuilder<UsersController>(builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.userPic != null) {
                      controller.userPic = null;
                      controller.update();
                    } else {
                      controller.pickImage();
                    }
                  },
                  child: Icon(
                    controller.userPic == null
                        ? Icons.add_circle_outline_outlined
                        : Icons.delete,
                    size: 22.sp,
                    color: controller.userPic == null
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
