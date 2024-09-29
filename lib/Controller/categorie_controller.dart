import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CategorieController extends GetxController {
 late TextEditingController categorieName;

  @override
  void onInit() {
    categorieName = TextEditingController();
    super.onInit();
  }
}
