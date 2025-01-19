import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/categorie_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_form_field.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/field_validator.dart';

void addNewCategorie(BuildContext context) {
  CategorieController controller = Get.find<CategorieController>();
  Get.dialog(
    AlertDialog(
      content: SizedBox(
        height: 130.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: controller.key,
              child: AppFormField(
                hint: 'categorie name',
                prefixIcon: const Icon(Icons.category_sharp),
                textController: controller.categorieName,
                validator: (value) => appValidator(
                  value: value.toString(),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  text: 'cancel',
                  height: 40.h,
                  width: 100.w,
                  textSize: 14.sp,
                  color: AppColor.deleteColor,
                ),
                AppButton(
                  text: 'Add',
                  height: 40.h,
                  width: 100.w,
                  textSize: 14.sp,
                  color: AppColor.greencolor,
                  onTap: () {
                    controller.addProduct(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ),
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.bounceInOut,
  );
}
