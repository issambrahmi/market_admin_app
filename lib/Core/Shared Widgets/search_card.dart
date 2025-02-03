import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_form_field.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(
      {super.key,
      required this.controller,
      required this.validator,
      required this.reqState,
      required this.names,
      required this.isNmaesShow,
      this.onSearch,
      this.showNames,
      required this.onTap});

  final TextEditingController controller;
  final String? Function(String?) validator;
  final Rx<RequestEnum> reqState;
  final List names;
  final RxBool isNmaesShow;
  final void Function(int? index) onTap;
  final void Function(String)? onSearch;

  final bool? showNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
      child: Column(
        children: [
          AppFormField(
            hint: 'search',
            prefixIcon: const Icon(Icons.search),
            textController: controller,
            validator: validator,
            enableBorder: false,
            onSearch: onSearch,
            onChanged: (value) {
              if (showNames != false) {
                isNmaesShow.value = value.trim().isNotEmpty;
              }
            },
          ),
          Obx(() {
            return isNmaesShow.value == true
                ? reqState.value == RequestEnum.waiting
                    ? Container(
                        padding: EdgeInsets.all(30.sp),
                        margin: EdgeInsets.only(top: 10.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: AppColor.mainScreencolor)),
                        child: Center(
                          child: CircularProgressIndicator(
                              color: AppColor.greencolor),
                        ),
                      )
                    : reqState.value == RequestEnum.successes
                        ? names.isEmpty
                            ? Container(
                                height: 100.h,
                                padding: EdgeInsets.all(10.sp),
                                margin: EdgeInsets.only(top: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: AppColor.mainScreencolor)),
                                child: const Center(
                                    child: Text('No result found')))
                            : Container(
                                height: names.length > 5
                                    ? 180.h
                                    : (names.length) * 38.h,
                                padding: EdgeInsets.all(10.sp),
                                margin: EdgeInsets.only(top: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: AppColor.mainScreencolor)),
                                child: ListView.separated(
                                  itemCount: names.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      thickness: 0.5,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        onTap(index);
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          names[index],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                        : reqState.value == RequestEnum.serverError
                            ? Container(
                                height: 100.h,
                                padding: EdgeInsets.all(10.sp),
                                margin: EdgeInsets.only(top: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: AppColor.mainScreencolor)),
                                child: const Center(
                                  child: Text('server err'),
                                ),
                              )
                            : const SizedBox()
                : const SizedBox();
          })
        ],
      ),
    );
  }
}
