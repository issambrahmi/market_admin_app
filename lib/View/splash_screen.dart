import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:market_admin_app/View/Home%20Page/home_page.dart';
import 'package:market_admin_app/View/LoginPage/login_page.dart';
import 'package:market_admin_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextScreen();
    super.initState();
  }

  _navigateToNextScreen() async {
    final loginBox = await Hive.openBox('isLogin');
    final isLogin = loginBox.get('is_login');
    loginBox.close();

    Timer(const Duration(seconds: 1), () async {
      if (isLogin == true) {
        await _getUserData();
        Get.offAll(() => const HomePage());
      } else {
        Get.offAll(() => const LoginPage());
      }
    });
  }

  _getUserData() async {
    final userBox = await Hive.openBox('user_box');
    token = userBox.get('user_data');
    userBox.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100.sp,
          width: 100.sp,
          color: Colors.green,
        )
      ),
    );
  }
}
