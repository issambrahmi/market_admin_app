import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Shared%20Widgets/field_validator.dart';
import 'package:market_admin_app/Shared%20Widgets/floating_action_button.dart';
import 'package:market_admin_app/Shared%20Widgets/search_card.dart';
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
        nextPage: () => const AddNewUserPage(),
        text: 'Add new user',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const AppTopSection(
                  text: 'Users',
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
