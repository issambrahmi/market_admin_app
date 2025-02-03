import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/categorie_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_alert_dialogue.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_circle_indicator.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Categories%20Page/commonW/add_new_categories_dialogue.dart';

class CategorieBody extends StatelessWidget {
  const CategorieBody({super.key});

  @override
  Widget build(BuildContext context) {
    CategorieController controller = Get.find<CategorieController>();

    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(() => controller.reqState.value == RequestEnum.waiting
              ? AppCircleIndicator(size: 40.sp)
              : controller.reqState.value == RequestEnum.serverError
                  ? const Center(child: CircularProgressIndicator())
                  : GetBuilder<CategorieController>(
                      builder: (controller) => controller.categories.isEmpty
                          ? const Center(child: Text('no users'))
                          : ListView.separated(
                              itemCount: controller.categories.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 5.h);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () =>
                                      addNewCategorie(context),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.categories[index].name,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => appAlertDialogue(
                                              context: context,
                                              height: 160.h,
                                              text:
                                                  'Are you sure yo want to delete this categorie',
                                              onTap: () {
                                                controller.deleteCategorie(index);
                                                Get.back();
                                              }),
                                          child: Container(
                                            padding: EdgeInsets.all(5.sp),
                                            child: Icon(
                                              Icons.delete,
                                              size: 20.sp,
                                              color: AppColor.deleteColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )))),
    );
  }
}
