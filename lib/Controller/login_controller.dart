import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'package:market_admin_app/Core/Services/hive_services.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/View/Home%20Page/home_page.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  late GlobalKey<FormState> key;
  RxBool isObsecure = true.obs;
  Rx<RequestEnum> reqState = RequestEnum.start.obs;
  Rx<String> errorMessage = ''.obs;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    key = GlobalKey<FormState>();
    super.onInit();
  }

  void login() async {
    reqState.value = RequestEnum.waiting;
    if (key.currentState!.validate()) {
      try {
        final response = await http.post(Uri.parse(AppLinks.loginLink),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'email': email.text.trim(),
              'password': password.text.trim(),
            }));
        if (response.statusCode == 200) {
          reqState.value = RequestEnum.successes;
          await HiveServices.saveUserData(
              token: jsonDecode(response.body)['token']);
          await HiveServices.changeIsLoginValue(isLogin: true);
          Get.offAll(() => const HomePage());
        } else if (response.statusCode == 400) {
          errorMessage.value = jsonDecode(response.body)['message'];
          reqState.value = RequestEnum.dataError;
        } else {
          reqState.value = RequestEnum.serverError;
        }
      } catch (e) {
        debugPrint('** $e');
        reqState.value = RequestEnum.serverError;
      }
    }
  }
}
