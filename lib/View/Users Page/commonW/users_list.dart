import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Users%20Page/commonW/user_card.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController controller = Get.find<UsersController>();
    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(() => controller.reqState.value == RequestEnum.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.reqState.value == RequestEnum.serverError
                  ? const Center(
                      child: Text('Server err'),
                    )
                  : controller.reqState.value == RequestEnum.successes
                      ? GetBuilder<UsersController>(builder: (controller) {
                          return controller.users.isEmpty
                              ? const Center(child: Text('No users found'))
                              : ListView.separated(
                                  itemCount: controller.showSearchedUsers
                                      ? controller.searchedUsers.length
                                      : controller.users.length + 1,
                                  controller: controller.scrollController,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10.h),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return index == controller.users.length &&
                                            !controller.isMaxUers
                                        //&&!controller.isSearchNmaesShow.value
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : index == controller.users.length &&
                                                controller.isMaxUers
                                            ? const SizedBox()
                                            : UserCard(index: index);
                                  },
                                );
                        })
                      : const SizedBox())),
    );
  }
}
