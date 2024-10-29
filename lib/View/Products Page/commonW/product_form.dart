import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/products_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_drop_down.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_form_field.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/field_validator.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsController controller = Get.find<ProductsController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Form(
          child: Column(
        children: [
          AppDropDownButton(
            height: 50.h,
            dropDowns: const ['Boisson', 'Fromage', 'Alimentation'],
            value: controller.userType,
            onChange: (value) {
              if (controller.userType != value) {
                controller.userType = value.toString();
                controller.update();
              }
            },
          ),
          SizedBox(height: 15.h),
          AppFormField(
              hint: 'product name',
              prefixIcon: Icon(
                Icons.production_quantity_limits,
                color: AppColor.greencolor,
              ),
              textController: controller.productName,
              validator: (txt) => appValidator(
                    value: txt.toString(),
                    isRequired: true,
                    isEmail: true,
                    minLength: 13,
                  )),
          SizedBox(height: 15.h),
          AppFormField(
            hint: 'prix en detaille',
            prefixIcon: Icon(
              Icons.price_change,
              color: AppColor.greencolor,
            ),
            textController: controller.prixDetailleController,
            validator: (txt) => appValidator(
              value: txt.toString(),
              isRequired: true,
              isEmail: true,
              minLength: 13,
            ),
            onChanged: (value) {
              if (value != '') {
                controller.prixDetaille = double.parse(value);
              }
            },
          ),
          SizedBox(height: 15.h),
          AppFormField(
            hint: 'prix en Gros',
            prefixIcon: Icon(
              Icons.price_change,
              color: AppColor.greencolor,
            ),
            textController: controller.prixGrosController,
            validator: (txt) => appValidator(
              value: txt.toString(),
              isRequired: true,
              isEmail: true,
              minLength: 13,
            ),
            onChanged: (value) {
              if (value != '') {
                controller.prixGros = double.parse(value);
              }
            },
          ),
          SizedBox(height: 15.h),
          AppFormField(
            hint: 'prix en SuperGros',
            prefixIcon: Icon(
              Icons.price_change,
              color: AppColor.greencolor,
            ),
            textController: controller.prixSuperGrosController,
            validator: (txt) => appValidator(
              value: txt.toString(),
              isRequired: true,
              isEmail: true,
              minLength: 13,
            ),
            onChanged: (value) {
              if (value != '') {
                controller.prixSuperGros = double.parse(value);
              }
            },
          ),
          SizedBox(height: 30.h),
          AppButton(
            text: 'Add product',
            height: 50.h,
            width: double.infinity,
            textSize: 18.sp,
            color: AppColor.greencolor,
            textColor: Colors.white,
          ),
        ],
      )),
    );
  }
}
