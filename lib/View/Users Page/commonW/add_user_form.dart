import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/Shared%20Widgets/app_button.dart';
import 'package:market_admin_app/Shared%20Widgets/app_drop_down.dart';
import 'package:market_admin_app/Shared%20Widgets/app_form_field.dart';
import 'package:market_admin_app/Shared%20Widgets/field_validator.dart';

class AddNewUserForm extends StatelessWidget {
  const AddNewUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController controller = Get.find<UsersController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Form(
          child: Column(
        children: [
          AppDropDownButton(
            height: 50.h,
            dropDowns: const ['Worker', 'Client'],
            value: controller.userType,
            onChange: (value) {
              if (controller.userType != value) {
                controller.userType = value.toString();
                controller.update();
              }
            },
          ),
          SizedBox(height: 15.h),
          AppFormField(
              hint: 'user email',
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
              hint: 'user password',
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
          SizedBox(height: 15.h),
          AppFormField(
              hint: 'username',
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
              hint: 'user phone number',
              prefixIcon: Icon(
                Icons.phone,
                color: AppColor.greencolor,
              ),
              textController: controller.userPhoneNumber,
              validator: (txt) => appValidator(
                    value: txt.toString(),
                    isRequired: true,
                    minLength: 10,
                    maxLength: 10,
                  )),
          SizedBox(height: 30.h),
          AppButton(
            text: 'Add user',
            height: 50.h,
            width: double.infinity,
            textSize: 18.sp,
            // gradient: LinearGradient(colors: [
            //   AppColor.darkBlue,
            //   AppColor.greencolor,
            // ]),
            color: AppColor.greencolor,
            textColor: Colors.white,
          ),
        ],
      )),
    );
  }
}
