import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_alert_dialogue.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/Model/Models/categorie_model.dart';
import 'package:http/http.dart' as http;

class CategorieController extends GetxController {
  List<CategorieModel> categories = [];

  late TextEditingController categorieName;
  late GlobalKey<FormState> key;

  Rx<RequestEnum> reqState = RequestEnum.start.obs; // for the user page
  Rx<RequestEnum> deleteReqState = RequestEnum.start.obs; // for the delete user
  Rx<RequestEnum> addReqState = RequestEnum.start.obs; // for the add user

  @override
  void onInit() {
    getCategories();
    categorieName = TextEditingController();
    key = GlobalKey<FormState>();
    super.onInit();
  }

  void getCategories() async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(AppLinks.getCategories));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['categories'];
        for (var categorie in data) {
          categories.add(CategorieModel.fromMap(categorie));
        }
        reqState.value = RequestEnum.successes;
      } else {
        reqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      reqState.value = RequestEnum.serverError;
    }
  }

  void deleteProduct(int index) async {
    deleteReqState.value = RequestEnum.waiting;
    try {
      final response = await http.delete(
          Uri.parse(
            AppLinks.deleteCategories,
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': categories[index].id,
          }));
      if (response.statusCode == 200) {
        categories.removeAt(index);
        deleteReqState.value = RequestEnum.successes;
        update();
      } else {
        deleteReqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      deleteReqState.value = RequestEnum.serverError;
    }
  }

  void addProduct(BuildContext context) async {
    addReqState.value = RequestEnum.waiting;
    if (key.currentState!.validate()) {
      try {
        final response = await http.post(Uri.parse(AppLinks.addCategories),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'name': categorieName.text.trim(),
            }));
        if (response.statusCode == 200) {
          categories.add(
              CategorieModel.fromMap(jsonDecode(response.body)['categorie']));
          categorieName.clear();
          addReqState.value = RequestEnum.successes;
          update();
          Get.back();
        } else if (response.statusCode == 400) {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('this categorie alredy ecxist'),
                duration: Duration(seconds: 2)),
          );
        } else {
          addReqState.value = RequestEnum.serverError;
        }
        categorieName.clear();
      } catch (e) {
        debugPrint('** $e');
        addReqState.value = RequestEnum.serverError;
      }
    }
  }
}
