import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/order_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/search_card.dart';
import 'package:market_admin_app/Core/functions/app_validator.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/orders_list.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/top_bar_order_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.put(OrderController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const TopBarOrderPage(),
                SizedBox(height: 80.h),
                const OrdersList(),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: SearchCard(
                controller: controller.searchCommande,
                validator: (value) => appValidator(value: value.toString()),
                reqState: controller.reqState,
                names: controller.names,
                isNmaesShow: controller.isNameShow,
                onTap: (index) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
