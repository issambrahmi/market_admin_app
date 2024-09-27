import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/products_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/add_new_product_page.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/products_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsController());
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(
          () => const AddNewProductPage(),
        ),
        label: Text(
          'Add new product',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.greencolor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const AppTopSection(
              text: 'Products',
            ),
            SizedBox(height: 15.h),
            const ProductsList(),
            
          ],
        ),
      ),
    );
  }
}
