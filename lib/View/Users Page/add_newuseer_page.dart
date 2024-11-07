import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Users%20Page/commonW/add_user_form.dart';
import 'package:market_admin_app/View/Users%20Page/commonW/choose_user_image.dart';

class AddNewUserPage extends StatelessWidget {
  const AddNewUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController controller = Get.find<UsersController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  AppTopSection(
                      text: controller.isAddPage
                          ? 'Add New ${controller.userType}'
                          : 'Edit ${controller.userType}'),
                  SizedBox(height: 15.h),
                  const ChooseUserImage(),
                  SizedBox(height: 30.h),
                  const AddNewUserForm()
                ],
              ),
            ),
            Obx(() => controller.addReqState.value == RequestEnum.waiting
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.greyColor,
                        value: 30.sp,
                      ),
                    ),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
