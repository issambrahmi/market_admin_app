import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_admin_app/Core/Constants/app_color.dart';

class ProductCardProductDetailes extends StatelessWidget {
  const ProductCardProductDetailes({super.key});

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
                'Boisson Ifri 1L ananas',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Qnt : 10',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'prix : 6500 DA',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            
            ],
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
