import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:market_admin_app/Controller/home_controller.dart';
import 'package:market_admin_app/View/Home%20Page/commonW/home_body.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';

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
          const HomeBody()
        ],
      )),
    );
  }
}
