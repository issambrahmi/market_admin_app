import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/order_d_bottom_sect.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/order_detaille_products.dart';

class OrdersDetailesPage extends StatelessWidget {
  const OrdersDetailesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopSection(text: 'Order detaille'),
            SizedBox(height: 10.h),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const OrderDetailesProducts(),
            )),
              const OrderDetailesDownSec(),
          ],
        ),
      ),
    );
  }
}
