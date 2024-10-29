import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/login_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/field_validator.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/LoginPage/commonW/login_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        LoginFormField(
                            hint: 'email',
                            prefixIcon: Icon(
                              Icons.email,
                              size: 25.sp,
                              color: AppColor.greencolor,
                            ),
                            textController: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (txt) => appValidator(
                                  value: txt.toString(),
                                  minLength: 10,
                                  maxLength: 100,
                                  isEmail: true,
                                  isRequired: true,
                                )),
                        SizedBox(height: 15.h),
                        Obx(() => LoginFormField(
                            hint: 'password',
                            prefixIcon: Icon(
                              Icons.password,
                              size: 25.sp,
                              color: AppColor.greencolor,
                            ),
                            textController: controller.password,
                            isPassword: true,
                            isObsecure: controller.isObsecure.value,
                            eyeTap: () => controller.isObsecure.value =
                                !controller.isObsecure.value,
                            validator: (txt) => appValidator(
                                  value: txt.toString(),
                                  minLength: 8,
                                  maxLength: 100,
                                  isPassword: true,
                                  isRequired: true,
                                ))),
                        SizedBox(height: 30.h),
                        AppButton(
                          text: 'Login',
                          height: 50.h,
                          width: double.infinity,
                          textSize: 18.sp,
                          gradient: LinearGradient(colors: [
                            AppColor.greencolor,
                            AppColor.darkBlue,
                          ]),
                          textColor: Colors.white,
                          onTap: () {
                            controller.login();
                          },
                        ),
                        SizedBox(height: 30.h),
                        Obx(() =>
                            controller.reqState.value == RequestEnum.dataError
                                ? Text(
                                    controller.errorMessage.value,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  )
                                : const SizedBox())
                      ],
                    ))
              ],
            ),
          ),
          Obx(() => controller.reqState.value == RequestEnum.waiting
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.greencolor,
                      value: 35.sp,
                    ),
                  ),
                )
              : const SizedBox())
        ],
      ),
    );
  }
}
