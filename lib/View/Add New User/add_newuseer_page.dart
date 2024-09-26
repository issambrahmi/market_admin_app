import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/add_new_user_controller.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/View/Add%20New%20User/commonW/add_user_form.dart';
import 'package:market_admin_app/View/Add%20New%20User/commonW/choose_user_image.dart';

class AddNewUserPage extends StatelessWidget {
  const AddNewUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddNewUserController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppTopSection(text: 'Add New User',),
              SizedBox(height: 40.h),
              const ChooseUserImage(),
              SizedBox(height: 40.h),
              const AddNewUserForm()
            ],
          ),
        ),
      ),
    );
  }
}
