import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/commandes_controller.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Shared%20Widgets/field_validator.dart';
import 'package:market_admin_app/Shared%20Widgets/search_card.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/orders_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    CommandesController controller = Get.put(CommandesController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const AppTopSection(
                  text: 'Commandes',
                ),
                SizedBox(height: 15.h),
                SizedBox(height: 60.h),
                const OrdersList(),
                SizedBox(height:  15.h),
              ],
            ),
            SearchCard(
              controller: controller.searchCommande,
              validator: (value) => appValidator(value: value.toString()),
            )
          ],
        ),
      ),
    );
  }
}
