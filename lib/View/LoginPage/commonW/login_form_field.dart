import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class LoginFormField extends StatelessWidget {
  const LoginFormField(
      {super.key,
      required this.hint,
      this.keyboardType,
      required this.prefixIcon,
      required this.textController,
      required this.validator,
      this.isPassword,
      this.eyeTap,
      this.isObsecure});
  final String hint;
  final TextInputType? keyboardType;
  final Widget prefixIcon;
  final TextEditingController textController;
  final String? Function(String?) validator;
  final bool? isPassword;
  final bool? isObsecure;
  final void Function()? eyeTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: TextFormField(
        controller: textController,
        validator: validator,
        cursorColor: AppColor.greencolor,
        obscureText: isObsecure ?? false,
        keyboardType: keyboardType ?? keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon,
          suffixIcon: isPassword == true
              ? GestureDetector(
                  onTap: eyeTap,
                  child: Icon(
                    Icons.remove_red_eye_rounded,
                    size: 20.sp,
                  ),
                )
              : null,
          fillColor: AppColor.mainScreencolor,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  width: 1.5, color: AppColor.mainScreencolor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.mainScreencolor)),
        ),
      ),
    );
  }
}
