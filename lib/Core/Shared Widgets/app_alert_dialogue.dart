import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_button.dart';

void appAlertDialogue(
    {required BuildContext context,
    required String text,
    required double height,
    required Function() onTap}) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'hi',
      barrierColor: Colors.black.withOpacity(0.5), // Background dimming
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: height,
              padding: EdgeInsets.all(20.sp),
              margin: EdgeInsets.all(30.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                        text: 'Cancel',
                        height: 40.h,
                        width: 115.w,
                        textSize: 15.sp,
                        color: AppColor.deleteColor,
                        onTap: () => Get.back(),
                      ),
                      AppButton(
                        text: 'Confirmer',
                        height: 40.h,
                        width: 115.w,
                        textSize: 13.sp,
                        gradient: LinearGradient(
                            colors: [AppColor.darkBlue, AppColor.greencolor]),
                        onTap: onTap,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}