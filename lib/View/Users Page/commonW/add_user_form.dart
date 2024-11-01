import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_form_field.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/field_validator.dart';

class AddNewUserForm extends StatelessWidget {
  const AddNewUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController controller = Get.find<UsersController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Form(
          key: controller.key,
          child: Column(
            children: [
              SizedBox(height: 15.h),
              AppFormField(
                  hint: ' ${controller.userType} name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppColor.greencolor,
                  ),
                  textController: controller.userName,
                  validator: (txt) => appValidator(
                        value: txt.toString(),
                        isRequired: true,
                        minLength: 4,
                        maxLength: 50,
                      )),
              SizedBox(height: 15.h),
              AppFormField(
                  hint: 'phone number',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: AppColor.greencolor,
                  ),
                  textController: controller.userPhoneNumber,
                  validator: (txt) => appValidator(
                        value: txt.toString(),
                        minLength: 0,
                        maxLength: 10,
                      )),
              SizedBox(height: 15.h),
              AppFormField(
                  hint: 'email',
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: AppColor.greencolor,
                  ),
                  textController: controller.userEmail,
                  validator: (txt) => appValidator(
                        value: txt.toString(),
                        isRequired: true,
                        isEmail: true,
                        minLength: 13,
                      )),
              SizedBox(height: 15.h),
              GetBuilder<UsersController>(builder: (controller) {
                return AppFormField(
                  hint: 'password',
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    color: AppColor.greencolor,
                  ),
                  isPassword: true,
                  isObsecure: !controller.isPasswordShow,
                  eyeTap: () {
                    controller.isPasswordShow = !controller.isPasswordShow;
                    controller.update();
                  },
                  textController: controller.userPassword,
                  validator: (txt) => appValidator(
                    isRequired: true,
                    value: txt.toString(),
                    isPassword: true,
                    minLength: 8,
                  ),
                );
              }),
              SizedBox(height: 30.h),
              AppButton(
                text: 'Add ${controller.userType}',
                height: 50.h,
                width: double.infinity,
                textSize: 18.sp,
                color: AppColor.greencolor,
                textColor: Colors.white,
                onTap: () {
                  controller.addUser();
                },
              ),
            ],
          )),
    );
  }
}
