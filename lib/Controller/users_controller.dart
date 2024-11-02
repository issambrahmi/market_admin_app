import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:http/http.dart' as http;
import 'package:market_admin_app/Model/Models/user_model.dart';

class UsersController extends GetxController {
  List<UserModel> users = [];
  List<UserModel> searchedUsers = [];
  List<String> usersNames = [];

  final ImagePicker _imagePicker = ImagePicker();
  XFile? userPic;
  late TextEditingController userEmail;
  late TextEditingController userPassword;
  late TextEditingController userPhoneNumber;
  late TextEditingController userName;
  late TextEditingController searchUser;
  late GlobalKey<FormState> key;
  bool isPasswordShow = false;
  bool isLoading = false;
  bool isMaxUers = false;
  RxBool isSearchNmaesShow = false.obs;
  bool isAddPage = true; // for switch between edit and add pages
  bool showSearchedUsers =
      false; // for switch between searched users and default users
  late String userType; // client or worker
  Rx<RequestEnum> reqState = RequestEnum.start.obs; // for the user page
  Rx<RequestEnum> deleteReqState = RequestEnum.start.obs; // for the delete user
  Rx<RequestEnum> addReqState = RequestEnum.start.obs; // for the add user
  Rx<RequestEnum> searchReqState = RequestEnum.start.obs; // for search
  Rx<String> errorMessage = ''.obs;
  final ScrollController scrollController = ScrollController();

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
    //////////////////////
    searchUser.addListener(() {
      if (searchUser.text.trim().isNotEmpty) {        
        usersNames.clear();
        searchUsersNames();
      }
    });
    //////////////////////////
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.9 &&
          !isLoading &&
          !isMaxUers) {
        loadMoreUsers();
      }
      ////////////////////////
    });
    super.onInit();
  }

  @override
  void onClose() {
    userEmail.dispose();
    userName.dispose();
    userPhoneNumber.dispose();
    userPassword.dispose();
    searchUser.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void pickImage() async {
    userPic = await _imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }

  void clearFields() {
    userName.clear();
    userEmail.clear();
    userPassword.clear();
    userPhoneNumber.clear();
    userPic = null;
  }

  void fillFields(UserModel user) {
    userName.text = user.username;
    userEmail.text = user.email;
    userPassword.text = user.password;
    userPhoneNumber.text = user.phoneNumber ?? '';
  }

  void getUsers() async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(
        userType == 'client'
            ? "${AppLinks.getClients}/0"
            : "${AppLinks.getWorkers}/0",
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

  void loadMoreUsers() async {
    isLoading = true;
    try {
      final response = await http.get(Uri.parse(
        userType == 'client'
            ? "${AppLinks.getClients}/${users.length}"
            : "${AppLinks.getWorkers}/${users.length}",
      ));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['users'];
        if (data.length < 16) {
          isMaxUers = true;
        }
        for (var user in data) {
          users.add(UserModel.fromMap(user));
        }
        update();
      }
      isLoading = false;
    } catch (e) {
      debugPrint('** $e');
      isLoading = false;
    }
  }

  void searchUsersNames() async {
    searchReqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(
        userType == 'client'
            ? "${AppLinks.searchClient}/${searchUser.text.trim()}"
            : "${AppLinks.searchWorker}/${searchUser.text.trim()}",
      ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['users'];
        data.forEach((user) {
          usersNames.add(user['username']);
        });
        searchReqState.value = RequestEnum.successes;
      } else if (response.statusCode == 400) {
        errorMessage.value = jsonDecode(response.body)['message'];
        searchReqState.value = RequestEnum.dataError;
      } else {
        searchReqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      searchReqState.value = RequestEnum.serverError;
    }
  }

  void searchForUsers() async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(
        userType == 'client'
            ? "${AppLinks.searchClient}/${searchUser.text.trim()}"
            : "${AppLinks.searchWorker}/${searchUser.text.trim()}",
      ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['users'];
        data.forEach((user) {
          searchedUsers.add(UserModel.fromMap(user));
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
    addReqState.value = RequestEnum.waiting;
    if (key.currentState!.validate()) {
      try {
        final response = await http.post(
            Uri.parse(
              userType == 'client' ? AppLinks.addClient : AppLinks.addWorker,
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
          addReqState.value = RequestEnum.successes;
          Get.back();
        } else if (response.statusCode == 400) {
          errorMessage.value = jsonDecode(response.body)['message'];
          addReqState.value = RequestEnum.dataError;
        } else {
          addReqState.value = RequestEnum.serverError;
        }
      } catch (e) {
        debugPrint('** $e');
        addReqState.value = RequestEnum.serverError;
      }
    }
    addReqState.value = RequestEnum.start;
  }

  void deleteUser(int index) async {
    deleteReqState.value = RequestEnum.waiting;
    try {
      final response = await http.delete(
          Uri.parse(
            userType == 'client'
                ? AppLinks.deleteClient
                : AppLinks.deleteWorker,
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': users[index].id,
          }));
      if (response.statusCode == 200) {
        users.removeAt(index);
        deleteReqState.value = RequestEnum.successes;
        update();
      } else if (response.statusCode == 400) {
        errorMessage.value = jsonDecode(response.body)['message'];
        deleteReqState.value = RequestEnum.dataError;
      } else {
        deleteReqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      deleteReqState.value = RequestEnum.serverError;
    }
  }

  void updateUser(int index) async {
    deleteReqState.value = RequestEnum.waiting;
    try {
      final response = await http.put(
          Uri.parse(
            userType == 'client' ? AppLinks.editClient : AppLinks.editWorker,
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': users[index].id,
            'username': users[index].username,
            'email': users[index].email,
            'password': users[index].id,
            'id': users[index].id,
          }));
      if (response.statusCode == 200) {
        users.removeAt(index);
        deleteReqState.value = RequestEnum.successes;
        update();
      } else if (response.statusCode == 400) {
        errorMessage.value = jsonDecode(response.body)['message'];
        deleteReqState.value = RequestEnum.dataError;
      } else {
        deleteReqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      deleteReqState.value = RequestEnum.serverError;
    }
  }
}
