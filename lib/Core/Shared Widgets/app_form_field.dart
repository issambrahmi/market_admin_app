import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class AppFormField extends StatelessWidget {
  const AppFormField(
      {super.key,
      required this.hint,
      this.keyboardType,
      required this.prefixIcon,
      required this.textController,
      required this.validator,
      this.isPassword,
      this.eyeTap,
      this.isObsecure,
      this.onChanged,
      this.enableBorder});
  final String hint;
  final TextInputType? keyboardType;
  final Widget prefixIcon;
  final TextEditingController textController;
  final String? Function(String?) validator;
  final bool? isPassword;
  final bool? isObsecure;
  final void Function()? eyeTap;
  final void Function(String)? onChanged;
  final bool? enableBorder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: TextFormField(
        cursorColor: AppColor.greencolor,
        controller: textController,
        validator: validator,
        onChanged: onChanged,
        obscureText: isObsecure ?? false,
        keyboardType: keyboardType ?? keyboardType,
        decoration: InputDecoration(
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
          // contentPadding:
          //     EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          //   fillColor: MyColors.mainColor,
          // //  filled: true,
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.black45),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  width: 1.5, color: AppColor.mainScreencolor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: enableBorder == false
                  ? const BorderSide(
                      color: AppColor.mainScreencolor, width: 1.5)
                  : const BorderSide(color: Colors.black, width: 1.5)),
        ),
      ),
    );
  }
}
