import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/field_validator.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/floating_action_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/search_card.dart';
import 'package:market_admin_app/Model/Enums/user_type_enum.dart';
import 'package:market_admin_app/View/Users%20Page/add_newuseer_page.dart';
import 'package:market_admin_app/View/Users%20Page/commonW/users_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key, required this.userT});
  final UserTYpeEnum userT;
  @override
  Widget build(BuildContext context) {
    UsersController controller = Get.put(UsersController());
    controller.userType = userT;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AppFloatingActionButton(
        nextPage: () => const AddNewUserPage(),
        text: 'Add new user',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                 AppTopSection(
                  text: controller.userType == UserTYpeEnum.client ? 'Client' : 'Worker',
                ),
                SizedBox(height: 15.h),
                SizedBox(height: 60.h),
                const UsersList()
              ],
            ),
            SearchCard(
              controller: controller.searchUser,
              validator: (value) => appValidator(
                value: value.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
