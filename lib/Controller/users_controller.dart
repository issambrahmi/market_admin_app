import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/Model/Enums/user_type_enum.dart';
import 'package:http/http.dart' as http;
import 'package:market_admin_app/Model/Models/user_model.dart';

class UsersController extends GetxController {
  List<UserModel> users = [];
  final ImagePicker _imagePicker = ImagePicker();
  XFile? userPic;
  late TextEditingController userEmail;
  late TextEditingController userPassword;
  late TextEditingController userPhoneNumber;
  late TextEditingController userName;
  late TextEditingController searchUser;
  late GlobalKey<FormState> key;
  bool isPasswordShow = false;
  late UserTYpeEnum userType;
  Rx<RequestEnum> reqState = RequestEnum.start.obs;
  Rx<String> errorMessage = ''.obs;

  @override
  void onInit() {
    userType = Get.arguments;
    getUsers();
    userEmail = TextEditingController();
    userPassword = TextEditingController();
    userPhoneNumber = TextEditingController();
    userName = TextEditingController();
    searchUser = TextEditingController();
    key = GlobalKey<FormState>();
    super.onInit();
  }

  void pickImage() async {
    userPic = await _imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }

  void getUsers() async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(
        userType == UserTYpeEnum.client
            ? "${AppLinks.getClients}/${users.length}"
            : "${AppLinks.getWorkers}/${users.length}",
      ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['users'];
        data.forEach((user) {
          users.add(UserModel.fromMap(user));
        });
        reqState.value = RequestEnum.successes;
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

  void addUser() async {
    reqState.value = RequestEnum.waiting;
    if (key.currentState!.validate()) {
      try {
        final response = await http.post(
            Uri.parse(
              userType == UserTYpeEnum.client
                  ? AppLinks.addClient
                  : AppLinks.addWorker,
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'email': userEmail.text.trim(),
              'password': userPassword.text.trim(),
              'username': userName.text.trim(),
              'phoneNumber': userPhoneNumber.text.trim(),
            }));
        if (response.statusCode == 200) {
          reqState.value = RequestEnum.successes;
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
