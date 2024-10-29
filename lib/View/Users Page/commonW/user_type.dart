// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:market_admin_app/Controller/users_controller.dart';
// import 'package:market_admin_app/Core/app_color.dart';
// import 'package:market_admin_app/Model/user_type_enum.dart';

// class UserTypeContainer extends StatelessWidget {
//   const UserTypeContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40.h,
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 20.w),
//       decoration: BoxDecoration(   
//         borderRadius: BorderRadius.circular(15),
//         color: AppColor.mainScreencolor,
//       ),
//       child: GetBuilder<UsersController>(builder: (controller) {
//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             AnimatedAlign(
//               duration: const Duration(milliseconds: 300),
//               alignment: controller.cartState == UserTYpeEnum.client
//                   ? Alignment.centerLeft
//                   : Alignment.centerRight,
//               child: Container(
//                 height: double.infinity,
//                 width: 120.w,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     gradient: LinearGradient(colors: [
//                       AppColor.darkBlue.withOpacity(0.8),
//                       AppColor.greencolor.withOpacity(
//                         0.8,
//                       )
//                     ])),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () =>
//                         controller.onChangecarttState(UserTYpeEnum.client),
//                     child: Container(
//                       height: double.infinity,
//                       width: 80.w,
//                       color: Colors.transparent,
//                       child: Center(
//                         child: Text(
//                           'Clients',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.sp,
//                               color: controller.cartState == UserTYpeEnum.client
//                                   ? Colors.white
//                                   : Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () =>
//                         controller.onChangecarttState(UserTYpeEnum.worker),
//                     child: Container(
//                       height: double.infinity,
//                       width: 80.w,
//                       color: Colors.transparent,
//                       child: Center(
//                         child: Text(
//                           'Worker',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.sp,
//                               color: controller.cartState == UserTYpeEnum.worker
//                                   ? Colors.white
//                                   : Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
