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
          key: controller.key,
          child: Column(
            children: [
              AppDropDownButton(
                height: 50.h,
                dropDowns: controller.categories.map((c) => c.name).toList(),
                value: controller.categorieValue,
                onChange: (value) {
                  if (controller.categorieValue != value) {
                    controller.categorieValue = value.toString();
                    controller.update();
                  }
                },
              ),
              SizedBox(height: 15.h),
              AppFormField(
                  hint: 'product name',
                  prefixIcon: Icon(
                    Icons.description,
                    color: AppColor.greencolor,
                  ),
                  textController: controller.productName,
                  validator: (txt) => appValidator(
                        value: txt.toString(),
                        isRequired: true,
                        minLength: 1,
                      )),
              SizedBox(height: 15.h),
              AppFormField(
                hint: 'prix en detaille',
                prefixIcon: Icon(
                  Icons.price_change,
                  color: AppColor.greencolor,
                ),
                textController: controller.priceDetailleController,
                keyboardType: TextInputType.number,
                validator: (txt) => appValidator(
                  value: txt.toString(),
                  isRequired: true,
                  minLength: 1,
                ),
              ),
              SizedBox(height: 15.h),
              AppFormField(
                hint: 'prix en Gros',
                prefixIcon: Icon(
                  Icons.price_change,
                  color: AppColor.greencolor,
                ),
                textController: controller.priceGrosController,
                keyboardType: TextInputType.number,
                validator: (txt) => appValidator(
                  value: txt.toString(),
                  isRequired: true,
                  minLength: 1,
                ),
              ),
              SizedBox(height: 15.h),
              AppFormField(
                hint: 'prix en SuperGros',
                prefixIcon: Icon(
                  Icons.price_change,
                  color: AppColor.greencolor,
                ),
                textController: controller.priceSuperGrosController,
                keyboardType: TextInputType.number,
                validator: (txt) => appValidator(
                  value: txt.toString(),
                  isRequired: true,
                  minLength: 1,
                ),
              ),
              SizedBox(height: 15.h),
              AppFormField(
                hint: 'min quantite gros',
                prefixIcon: Icon(
                  Icons.production_quantity_limits_sharp,
                  color: AppColor.greencolor,
                ),
                textController: controller.minQntGros,
                keyboardType: TextInputType.number,
                validator: (txt) => appValidator(
                  value: txt.toString(),
                  isRequired: true,
                  minLength: 1,
                ),
              ),
              SizedBox(height: 15.h),
              AppFormField(
                hint: 'min quantite superGros',
                prefixIcon: Icon(
                  Icons.production_quantity_limits_sharp,
                  color: AppColor.greencolor,
                ),
                textController: controller.minQntSuperGros,
                keyboardType: TextInputType.number,
                validator: (txt) => appValidator(
                  value: txt.toString(),
                  isRequired: true,
                  minLength: 1,
                ),
              ),
              SizedBox(height: 30.h),
              AppButton(
                text: controller.isAddPage ? 'Add product' : 'Edit product',
                height: 50.h,
                width: double.infinity,
                textSize: 18.sp,
                color: AppColor.greencolor,
                textColor: Colors.white,
                onTap: () {
                  controller.isAddPage ? controller.addProduct() : controller.updateProduct();
                },
              ),
              SizedBox(height: 30.h),
            ],
          )),
    );
  }
}
