import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewUserController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? userPic;
  late TextEditingController userEmail;
  late TextEditingController userPassword;
  late GlobalKey<FormState> key;
  bool isPasswordShow = false;

  @override
  void onInit() {
    userEmail = TextEditingController();
    userPassword = TextEditingController();
    key = GlobalKey<FormState>();
    super.onInit();
  }

  void pickImage() async {
    userPic = await _imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }
}
