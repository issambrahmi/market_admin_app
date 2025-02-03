import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/home_controller.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Core/Services/hive_services.dart';
import 'package:market_admin_app/View/Home%20Page/commonW/home_body.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/View/splash_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          const AppTopSection(
            text: 'Soltani Market',
            isHome: true,
          ),
          SizedBox(height: 15.h),
          const HomeBody(),
          InkWell(
            onTap: () async {
              await HiveServices.clearUserData();
              await HiveServices.changeIsLoginValue(isLogin: false);
              Get.offAll(() => const SplashScreen());
            },
            child: Container(
              height: 40.sp,
              width: 40.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColor.greencolor,
              ),
            ),
          )
        ],
      )),
    );
  }
}
