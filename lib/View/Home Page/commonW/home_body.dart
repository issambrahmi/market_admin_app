import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:market_admin_app/Controller/home_controller.dart';
import 'package:market_admin_app/View/Home%20Page/commonW/home_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.separated(
          itemCount: Get.find<HomeController>().cards.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10.h);
          },
          itemBuilder: (BuildContext context, int index) {
            return HomeCard(
              index: index,
            );
          },
        ),
      ),
    );
  }
}
