import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/users_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Model/Enums/user_type_enum.dart';
import 'package:market_admin_app/View/Users%20Page/add_newuseer_page.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    UsersController controller = Get.find<UsersController>();
    return GestureDetector(
      onTap: () => Get.to(() => const AddNewUserPage()),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 3),
                color: AppColor.mainScreencolor,
                blurRadius: 2,
              )
            ]),
        child: Row(
          children: [
            SizedBox(
              height: 50.sp,
              width: 50.sp,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/images/person.png',
                ),
              ),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 50.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.users[index].username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    controller.userType == UserTYpeEnum.client
                        ? 'Client'
                        : 'Worker',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greencolor,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.all(5.sp),
              child: Icon(
                Icons.delete,
                size: 20.sp,
                color: AppColor.deleteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
