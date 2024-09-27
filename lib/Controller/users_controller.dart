import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UsersController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? userPic;
  late TextEditingController userEmail;
  late TextEditingController userPassword;
  late TextEditingController userPhoneNumber;
  late TextEditingController userName;
  late GlobalKey<FormState> key;
  bool isPasswordShow = false;
  String userType = 'Client';

  @override
  void onInit() {
    userEmail = TextEditingController();
    userPassword = TextEditingController();
    userPhoneNumber = TextEditingController();
    userName = TextEditingController();

    key = GlobalKey<FormState>();
    super.onInit();
  }

  void pickImage() async {
    userPic = await _imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }
 
}
