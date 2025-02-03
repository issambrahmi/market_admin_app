import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/Model/Models/order_model.dart';
import 'package:market_admin_app/Model/Models/product_model.dart';
import 'package:market_admin_app/Model/Models/user_model.dart';

class OrderController extends GetxController {
  late TextEditingController searchValue;

  List<OrderModel> newOrders = [];
  List<OrderModel> acceptedOrders = [];
  List<OrderModel> searchedOrders = [];
  List<UserModel> workers = [];
  List names = [];
  OrderModel? searchedOrder;
  int orderIndex = 0;
  String workerName = '';

  Rx<RequestEnum> reqState = RequestEnum.start.obs; // for the product page
  Rx<RequestEnum> deleteReqState =
      RequestEnum.start.obs; // for the delete order
  Rx<RequestEnum> orderDetaillesState =
      RequestEnum.start.obs; // for the order detailles page
  Rx<RequestEnum> workersState =
      RequestEnum.start.obs; // for the workers loading
  Rx<RequestEnum> acceptOrderState =
      RequestEnum.start.obs; // loading for accept order
  RxBool isNameShow = false.obs;
  RxBool isAccepted = false.obs;
  RxBool isSearched = false.obs;
  bool isMaxAcceptedOrders = false;
  bool isMaxNewOrders = false;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    searchValue = TextEditingController();
    getOrders();
    //////////////////////////
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if ((isAccepted.value && !isMaxAcceptedOrders) ||
            (!isAccepted.value && !isMaxNewOrders)) {
          loadMoreOrders();
        }
      }
    });
    ////////////////////////
    super.onInit();
  }

  void switchBetweenNewAndAcceptedOrders(bool isPressOnAceeptedButton) {
    // user press on accepted button
    if (isPressOnAceeptedButton && !isAccepted.value) {
      isAccepted.value = !isAccepted.value;
      // press on new button
    } else if (!isPressOnAceeptedButton && isAccepted.value) {
      isAccepted.value = !isAccepted.value;
    }
  }

  void getWorkers() async {
    if (workers.isNotEmpty) {
      workersState.value = RequestEnum.successes;
      return;
    }
    workersState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(AppLinks.getWorkers));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['users'];
        for (var user in data) {
          workers.add(UserModel.fromMap(user));
        }
        if (workers.isNotEmpty) {
          workerName = workers[0].username;
        }
        workersState.value = RequestEnum.successes;
      } else {
        workersState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      workersState.value = RequestEnum.serverError;
    }
  }

  void getOrderItems(int? orderId, int index, bool isSearch) async {
    if (!isSearch &&
        ((isAccepted.value && acceptedOrders[index].orderItems.isNotEmpty) ||
            (!isAccepted.value && newOrders[index].orderItems.isNotEmpty))) {
      orderDetaillesState.value = RequestEnum.successes;
      return;
    }
    orderDetaillesState.value = RequestEnum.waiting;
    try {
      final response =
          await http.get(Uri.parse('${AppLinks.getOrderItems}/$orderId'));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['items'];
        for (var orderItem in data) {
          final ProductModel product = ProductModel.fromMap(orderItem);
          orderItem['product'] = product;
          if (isSearch) {
            searchedOrder!.orderItems.add(OrderItem.fromMap(orderItem));
          } else if (isAccepted.value) {
            acceptedOrders[index].orderItems.add(OrderItem.fromMap(orderItem));
          } else {
            newOrders[index].orderItems.add(OrderItem.fromMap(orderItem));
          }
        }
        orderDetaillesState.value = RequestEnum.successes;
      } else {
        orderDetaillesState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      orderDetaillesState.value = RequestEnum.serverError;
    }
  }

  void getOrders() async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(AppLinks.getOrders));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['orders'];
        for (var order in data) {
          if (order['is_accepted'] == 1) {
            acceptedOrders.add(OrderModel.fromMap(order));
          } else {
            newOrders.add(OrderModel.fromMap(order));
          }
        }
        //test max orders
        if (acceptedOrders.length < 30) {
          isMaxAcceptedOrders = true;
        }
        if (newOrders.length < 30) {
          isMaxNewOrders = true;
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

  void loadMoreOrders() async {
    try {
      final response = await http.get(Uri.parse(
        isAccepted.value
            ? "${AppLinks.getOrders}/1/${acceptedOrders.length}"
            : "${AppLinks.getOrders}/0/${newOrders.length}",
      ));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['orders'];
        if (data.length < 30) {
          isAccepted.value ? isMaxAcceptedOrders = true : isMaxNewOrders = true;
        }
        if (isAccepted.value) {
          for (var order in data) {
            acceptedOrders.add(OrderModel.fromMap(order));
          }
        } else {
          for (var order in data) {
            acceptedOrders.add(OrderModel.fromMap(order));
          }
        }
      }
    } catch (e) {
      debugPrint('** $e');
    }
  }

  void deleteOrder(int index) async {
    deleteReqState.value = RequestEnum.waiting;
    try {
      final response = await http.delete(
          Uri.parse(
            AppLinks.deleteOrder,
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'orderId': newOrders[index].id}));
      if (response.statusCode == 200) {
        newOrders.removeAt(index);
        deleteReqState.value = RequestEnum.successes;
        update();
        Get.back();
      } else {
        deleteReqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      deleteReqState.value = RequestEnum.serverError;
    }
  }

  void acceptOrder({required int orderIndex}) async {
    acceptOrderState.value = RequestEnum.waiting;
    try {
      final response = await http.post(
          Uri.parse(
            AppLinks.acceptOrder,
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'orderId': newOrders[orderIndex].id,
            'workerId': workers
                .firstWhere((worker) => worker.username == workerName)
                .id,
          }));
      if (response.statusCode == 200) {
        if (isSearched.value == false) {
          newOrders[orderIndex].workerName = workerName;
          acceptedOrders.add(newOrders[orderIndex]);
          newOrders.removeAt(orderIndex);
        } else {
          acceptedOrders.add(searchedOrder as OrderModel);
          newOrders.removeWhere((order) => order.id == searchedOrder!.id);
        }
        acceptOrderState.value = RequestEnum.successes;
        update();
        Get.back();
      } else {
        acceptOrderState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      acceptOrderState.value = RequestEnum.serverError;
    }
  }

  void searchOrders() async {
    searchedOrder = null;
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(
          Uri.parse("${AppLinks.searchOrder}/1/${searchValue.text.trim()}"));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['orders'];
        if (data.isNotEmpty) {
          searchedOrder = OrderModel.fromMap(data[0]);
        }
        isSearched.value = true;
        reqState.value = RequestEnum.successes;
        update();
      } else {
        reqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      reqState.value = RequestEnum.serverError;
    }
  }
}
