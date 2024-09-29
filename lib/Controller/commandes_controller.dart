import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CommandesController extends GetxController {
  late TextEditingController searchCommande;

  @override
  void onInit() {
    searchCommande = TextEditingController();
    super.onInit();
  }
}
