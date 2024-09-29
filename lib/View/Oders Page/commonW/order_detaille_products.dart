import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/View/Oders%20Page/commonW/order_d_product_card.dart';

class OrderDetailesProducts extends StatelessWidget {
  const OrderDetailesProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      //physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemBuilder: (BuildContext context, int index) {
        return const ProductCardProductDetailes();
      },
    );
  }
}
