import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/choose_product_image.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/product_form.dart';

class AddNewProductPage extends StatelessWidget {
  const AddNewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppTopSection(
                text: 'Add new product',
              ),
              SizedBox(height: 15.h),
              const ChooseProductImage(),
              SizedBox(height: 30.h),
            const ProductForm(),
            ],
          ),
        ),
      ),
    );
  }
}
