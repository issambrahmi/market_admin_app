import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'package:market_admin_app/Model/Enums/request_enum.dart';
import 'package:market_admin_app/Model/Models/categorie_model.dart';
import 'package:market_admin_app/Model/Models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  List<ProductModel> products = [];
  List<ProductModel> searchedProducts = [];
  List<String> productsNames = [];
  List<CategorieModel> categories = [];
  final ImagePicker _imagePicker = ImagePicker();
  XFile? productPic;
  late TextEditingController productName;
  late TextEditingController priceDetailleController;
  late TextEditingController priceGrosController;
  late TextEditingController priceSuperGrosController;
  late TextEditingController minQntGros;
  late TextEditingController minQntSuperGros;
  late TextEditingController searchProduct;
  final ScrollController scrollController = ScrollController();

  late GlobalKey<FormState> key;
  String categorieValue = '';

  bool isMaxUers = false;
  RxBool isSearchNmaesShow = false.obs;
  bool isAddPage = true; // for switch between edit and add pages
  bool showSearchedUsers =
      false; // for switch between searched products and default products
  bool isCategorieLoad = false;
  Rx<RequestEnum> reqState = RequestEnum.start.obs; // for the user page
  Rx<RequestEnum> deleteReqState = RequestEnum.start.obs; // for the delete user
  Rx<RequestEnum> addReqState = RequestEnum.start.obs; // for the add user
  Rx<RequestEnum> searchReqState = RequestEnum.start.obs; // for search
  Rx<RequestEnum> categorieReqState =
      RequestEnum.start.obs; // for categories loading

  Rx<String> errorMessage = ''.obs;

  @override
  void onInit() {
    getProducts();
    productName = TextEditingController();
    priceDetailleController = TextEditingController();
    priceGrosController = TextEditingController();
    priceSuperGrosController = TextEditingController();
    minQntGros = TextEditingController();
    minQntSuperGros = TextEditingController();
    searchProduct = TextEditingController();
    key = GlobalKey<FormState>();

    searchProduct.addListener(() {
      if (searchProduct.text.trim().isNotEmpty) {
        productsNames.clear();
        searchProductsNames();
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        loadMoreProducts();
      }
    });
    super.onInit();
  }

  void pickImage() async {
    productPic = await _imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }

  void clearFields() {
    productName.clear();
    priceDetailleController.clear();
    priceGrosController.clear();
    priceSuperGrosController.clear();
    minQntGros.clear();
    minQntSuperGros.clear();
    productPic = null;
  }

  void fillFields(ProductModel product) {
    productName.text = product.name;
    priceDetailleController.text = product.priceD.toString();
    priceGrosController.text = product.priceG.toString();
    priceSuperGrosController.text = product.priceSG.toString();
    minQntGros.text = product.minQntG.toString();
    minQntSuperGros.text = product.minQntSG.toString();
  }

  void getProducts() async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse("${AppLinks.getProduct}/0"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'];
        data.forEach((product) {
          products.add(ProductModel.fromMap(product));
        });
        if (products.length < 16) {
          isMaxUers = true;
          update();
        }
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

  void loadMoreProducts() async {
    try {
      final response = await http
          .get(Uri.parse("${AppLinks.getProduct}/${products.length}"));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['users'];
        if (data.length < 16) {
          isMaxUers = true;
        }
        for (var user in data) {
          products.add(ProductModel.fromMap(user));
        }
        update();
      }
    } catch (e) {
      debugPrint('** $e');
    }
  }

  void searchProductsNames() async {
    searchReqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(
        "${AppLinks.searchProduct}/${searchProduct.text.trim()}",
      ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'];
        data.forEach((product) {
          productsNames.add(product['name']);
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

  void searchForProducts() async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(
        "${AppLinks.searchProduct}/${searchProduct.text.trim()}",
      ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'];
        data.forEach((product) {
          searchedProducts.add(ProductModel.fromMap(product));
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

  void addProduct() async {
    addReqState.value = RequestEnum.waiting;
    if (key.currentState!.validate()) {
      try {
        final Map<String, dynamic> product = {
          'name': productName.text.trim(),
          'categorieId':
              categories.firstWhere((c) => c.name == categorieValue).id,
          'priceD': priceDetailleController.text.trim(),
          'priceG': priceGrosController.text.trim(),
          'priceSG': priceSuperGrosController.text.trim(),
          'minQntG': minQntGros.text.trim(),
          'minQntSG': minQntSuperGros.text.trim(),
        };
        final response = await http.post(Uri.parse(AppLinks.addProduct),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(product));
        if (response.statusCode == 200) {
          products
              .add(ProductModel.fromMap(jsonDecode(response.body)['product']));
          addReqState.value = RequestEnum.successes;
          clearFields();
          update();
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

  // void updateUser(int index) async {
  //   deleteReqState.value = RequestEnum.waiting;
  //   if (key.currentState!.validate()) {
  //     try {
  //       Map data = {};

  //       final response = await http.put(
  //           Uri.parse(
  //             AppLinks.editProduct,
  //           ),
  //           headers: {
  //             'Content-Type': 'application/json',
  //           },
  //           body: jsonEncode({
  //             'id': users[index].id,
  //             'username': users[index].username,
  //             'email': users[index].email,
  //             'password': users[index].id,
  //             'id': users[index].id,
  //           }));
  //       if (response.statusCode == 200) {
  //         users.removeAt(index);
  //         deleteReqState.value = RequestEnum.successes;
  //         update();
  //       } else if (response.statusCode == 400) {
  //         errorMessage.value = jsonDecode(response.body)['message'];
  //         deleteReqState.value = RequestEnum.dataError;
  //       } else {
  //         deleteReqState.value = RequestEnum.serverError;
  //       }
  //     } catch (e) {
  //       debugPrint('** $e');
  //       deleteReqState.value = RequestEnum.serverError;
  //     }
  //   }
  // }

  void loadCategories() async {
    categorieReqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(AppLinks.getCategories));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['categorie'];
        for (var categorie in data) {
          categories.add(CategorieModel.fromMap(categorie));
        }
        if (categories.isNotEmpty) {
          categorieValue = categories[0].name;
        }
        categorieReqState.value = RequestEnum.successes;
      } else {
        categorieReqState.value = RequestEnum.serverError;
      }
    } catch (e) {
      debugPrint('** $e');
      categorieReqState.value = RequestEnum.serverError;
    }
  }

  List _setUpdatedFields(ProductModel product, Map<String, dynamic> newData) {
    List updatedData = [];

    if (product.name != newData['name']) {
      updatedData.add(newData['name']);
    }

    if (product.priceD != newData['priceD']) {
      updatedData.add(newData['priceD']);
    }
    if (product.priceG != newData['priceG']) {
      updatedData.add(newData['priceG']);
    }
    if (product.priceSG != newData['priceSG']) {
      updatedData.add(newData['priceSG']);
    }
    if (product.minQntG != newData['minQntG']) {
      updatedData.add(newData['minQntG']);
    }
    if (product.minQntSG != newData['minQntSG']) {
      updatedData.add(newData['minQntSG']);
    }
    return updatedData;
  }
}
