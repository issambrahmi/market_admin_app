import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/add_new_user_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';

class ChooseUserImage extends StatelessWidget {
  const ChooseUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    AddNewUserController controller = Get.find<AddNewUserController>();
    return GestureDetector(
      onTap: () => controller.pickImage(),
      child: SizedBox(
        height: 80.sp,
        width: 80.sp,
        child: Stack(
          children: [
            GetBuilder<AddNewUserController>(builder: (controller) {
              return ClipRRect(
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
                        ));
            }),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: GetBuilder<AddNewUserController>(builder: (controller) {
                  return Icon(
                    controller.userPic == null
                        ? Icons.add_circle_outline_outlined
                        : Icons.create_rounded,
                    size: 22.sp,
                    color: controller.userPic == null
                        ? AppColor.greencolor
                        : Colors.orange,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
