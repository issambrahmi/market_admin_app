import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/categorie_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/View/Categories%20Page/commonW/add_new_categories_dialogue.dart';

class CategorieBody extends StatelessWidget {
  const CategorieBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 5.h);
          },
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => addNewCategorie(
                  Get.find<CategorieController>().categorieName),
              child: Container(
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        color: AppColor.mainScreencolor,
                        blurRadius: 2,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Boisson',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.sp),
                      child: Icon(
                        Icons.delete,
                        size: 20.sp,
                        color: AppColor.deleteColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
