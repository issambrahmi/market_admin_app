import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/products_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_circle_indicator.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/choose_product_image.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/product_form.dart';

class AddNewProductPage extends StatelessWidget {
  const AddNewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsController controller = Get.find<ProductsController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                AppTopSection(
                  text:
                      controller.isAddPage ? 'Add new product' : 'Edit product',
                ),
                Expanded(
                  child: Obx(
                    () => controller.categorieReqState.value ==
                            RequestEnum.waiting
                        ? Center(child: AppCircleIndicator(size: 40.sp))
                        : controller.categorieReqState.value ==
                                RequestEnum.serverError
                            ? const Center(child: Text('server err'))
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 15.h),
                                    const ChooseProductImage(),
                                    SizedBox(height: 30.h),
                                    const ProductForm(),
                                  ],
                                ),
                              ),
                  ),
                ),
              ],
            ),
            Obx(() => controller.addReqState.value == RequestEnum.waiting
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                    child: AppCircleIndicator(size: 40.sp))
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
