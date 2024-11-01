import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/field_validator.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/floating_action_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/search_card.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Users%20Page/add_newuseer_page.dart';
import 'package:market_admin_app/View/Users%20Page/commonW/users_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context) {
    UsersController controller = Get.put(UsersController());
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AppFloatingActionButton(
        onTap: () {
          controller.clearFields();
          Get.to(() => const AddNewUserPage());
        },
        text: 'Add new ${controller.userType}',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                AppTopSection(
                  text: controller.userType,
                ),
                SizedBox(height: 15.h),
                SizedBox(height: 60.h),
                const UsersList(),
              ],
            ),
            SearchCard(
              controller: controller.searchUser,
              validator: (value) => appValidator(
                value: value.toString(),
              ),
            ),
            controller.deleteReqState.value == RequestEnum.waiting
                ? Center(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child:
                          CircularProgressIndicator(color: AppColor.greencolor),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
