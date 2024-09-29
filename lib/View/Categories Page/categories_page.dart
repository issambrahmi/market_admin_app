import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/categorie_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/View/Categories%20Page/commonW/add_new_categories_dialogue.dart';
import 'package:market_admin_app/View/Categories%20Page/commonW/categorie_body.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategorieController controller = Get.put(CategorieController());
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addNewCategorie(controller.categorieName),
        label: Text(
          'Add categorie',
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
          const AppTopSection(text: 'Categories'),
          SizedBox(height: 20.h),
          const CategorieBody()
        ],
      )),
    );
  }
}
