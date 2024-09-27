import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:market_admin_app/Core/app_color.dart';
import 'package:market_admin_app/View/Users%20Page/add_newuseer_page.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const AddNewUserPage()),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
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
                    'Brahmi issam eddine',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Client',
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
              height: 25.sp,
              width: 25.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.deleteColor,
              ),
              child: Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}