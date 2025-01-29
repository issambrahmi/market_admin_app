import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';
import 'package:market_admin_app/Model/Models/order_model.dart';

class ProductCardProductDetailes extends StatelessWidget {
  const ProductCardProductDetailes({super.key, required this.item});

  final OrderItem item;
  @override
  Widget build(BuildContext context) {
    TextEditingController qnt = TextEditingController();
    qnt.text = '1';
    return Container(
      height: 100.sp,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 80.sp,
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                color: AppColor.mainScreencolor,
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset(
              'assets/images/ifri.png',
              // width: 80.w,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Qnt : ',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '${item.qnt}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'prix : ',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '${(item.qnt * item.product.priceD).toStringAsFixed(2)} DA',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
