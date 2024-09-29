import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/Shared%20Widgets/app_form_field.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(
      {super.key, required this.controller, required this.validator});

  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    RxBool isNmaesShow = false.obs;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
      child: Column(
        children: [
          AppFormField(
            hint: 'search',
            prefixIcon: const Icon(Icons.search),
            textController: controller,
            validator: validator,
            onChanged: (value) {
              isNmaesShow.value = value.trim().isNotEmpty;
            },
          ),
          Obx(() {
            return isNmaesShow.value == true
                ? Container(
                    height: 190.h,
                    padding: EdgeInsets.all(10.sp),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border(
                          bottom: BorderSide(color: AppColor.mainScreencolor),
                          right: BorderSide(color: AppColor.mainScreencolor),
                          left: BorderSide(color: AppColor.mainScreencolor)),
                    ),
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 0.5,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          'Brahmi issam Eddine',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox();
          })
        ],
      ),
    );
  }
}
