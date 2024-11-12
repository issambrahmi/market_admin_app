import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/Model/Models/categorie_model.dart';
import 'package:http/http.dart' as http;

class CategorieController extends GetxController {
  List<CategorieModel> categories = [];

  late TextEditingController categorieName;
  Rx<RequestEnum> reqState = RequestEnum.start.obs; // for the user page
  Rx<RequestEnum> deleteReqState = RequestEnum.start.obs; // for the delete user
  Rx<RequestEnum> addReqState = RequestEnum.start.obs; // for the add user

  @override
  void onInit() {
    getCategories();
    categorieName = TextEditingController();
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

  //  void addProduct() async {
  //   addReqState.value = RequestEnum.waiting;
  //   if (key.currentState!.validate()) {
  //     try {
  //       final Map<String, dynamic> product = {
  //         'name': productName.text.trim(),
  //         'categorieId':
  //             categories.firstWhere((c) => c.name == categorieValue).id,
  //         'priceD': priceDetailleController.text.trim(),
  //         'priceG': priceGrosController.text.trim(),
  //         'priceSG': priceSuperGrosController.text.trim(),
  //         'minQntG': minQntGros.text.trim(),
  //         'minQntSG': minQntSuperGros.text.trim(),
  //       };
  //       final response = await http.post(Uri.parse(AppLinks.addProduct),
  //           headers: {
  //             'Content-Type': 'application/json',
  //           },
  //           body: jsonEncode(product));
  //       if (response.statusCode == 200) {
  //         products
  //             .add(ProductModel.fromMap(jsonDecode(response.body)['product']));
  //         addReqState.value = RequestEnum.successes;
  //         clearFields();
  //         update();
  //         Get.back();
  //       } else if (response.statusCode == 400) {
  //         errorMessage.value = jsonDecode(response.body)['message'];
  //         addReqState.value = RequestEnum.dataError;
  //       } else {
  //         addReqState.value = RequestEnum.serverError;
  //       }
  //     } catch (e) {
  //       debugPrint('** $e');
  //       addReqState.value = RequestEnum.serverError;
  //     }
  //   }
  //   addReqState.value = RequestEnum.start;
  // }
}
