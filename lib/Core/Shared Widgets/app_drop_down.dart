import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class AppDropDownButton extends StatelessWidget {
  const AppDropDownButton(
      {super.key,
      required this.height,
      required this.dropDowns,
      required this.value,
      this.onChange});
  final double height;
  final List<String> dropDowns;
  final String value;
  final void Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DropdownButtonFormField<String>(
          //  dropdownColor: AppColor.mainScreencolor,
          value: value,
          decoration: InputDecoration(
              fillColor: AppColor.mainScreencolor,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
          items: List.generate(dropDowns.length, (index) {
            return DropdownMenuItem(
              value: dropDowns[index],
              child: Text(
                dropDowns[index],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
              ),
            );
          }),
          onChanged: onChange),
    );
  }
}
