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

  bool isMaxProducts = false;
  bool isMaxSearchedProducts = false;
  RxBool isSearchNmaesShow = false.obs; // for show searched names
  bool isAddPage = true; // for switch between edit and add pages
  bool showSearchedUsers =
      false; // for switch between searched products and default products
  bool isCategorieLoad = false;
  Rx<RequestEnum> reqState = RequestEnum.start.obs; // for the product page
  Rx<RequestEnum> deleteReqState = RequestEnum.start.obs; // for the delete product
  Rx<RequestEnum> addReqState = RequestEnum.start.obs; // for the add product
  Rx<RequestEnum> searchReqState = RequestEnum.start.obs; // for search
  Rx<RequestEnum> categorieReqState =
      RequestEnum.start.obs; // for categories loading

  int updatedProductIndex = 0;
  int productSearchedIndex = 0;
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
        if (showSearchedUsers) {
          loadMoreSearchProducts();
        } else {
          loadMoreProducts();
        }
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
    if (product.categorirName != null) {
      categorieValue = product.categorirName.toString();
    }
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
        final List data = jsonDecode(response.body)['products'];
        for (var product in data) {
          products.add(ProductModel.fromMap(product));
        }
        if (products.length < 16) {
          isMaxProducts = true;
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
        final List data = jsonDecode(response.body)['products'];
        if (data.length < 16) {
          isMaxProducts = true;
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
        List data = jsonDecode(response.body)['products'];
        for (var product in data) {
          productsNames.add(product['name']);
        }
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

  void searchForProducts(String? productName) async {
    reqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(
        "${AppLinks.searchProduct}/${productName == null ? searchProduct.text.trim() : productName.trim()}/0",
      ));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['products'];
        if (data.length < 16) {
          isMaxSearchedProducts = true;
        }
        for (var product in data) {
          searchedProducts.add(ProductModel.fromMap(product));
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

  void loadMoreSearchProducts() async {
    try {
      final response = await http.get(Uri.parse(
        "${AppLinks.searchProduct}/${searchProduct.text.trim()}/${searchedProducts.length}",
      ));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['products'];
        if (data.length < 16) {
          isMaxSearchedProducts = true;
        }
        for (var product in data) {
          searchedProducts.add(ProductModel.fromMap(product));
        }
      }
    } catch (e) {
      debugPrint('** $e');
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

  void updateProduct() async {
    addReqState.value = RequestEnum.waiting;
    if (key.currentState!.validate()) {
      try {
        final response = await http.put(
            Uri.parse(
              AppLinks.editProduct,
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'id': products[updatedProductIndex].id,
              'name': productName.text.trim(),
              'categorieId':
                  categories.firstWhere((c) => c.name == categorieValue).id,
              'priceD': double.parse(priceDetailleController.text.trim()),
              'priceG': double.parse(priceGrosController.text.trim()),
              'priceSG': double.parse(priceSuperGrosController.text.trim()),
              'minQntG': int.parse(minQntGros.text.trim()),
              'minQntSG': int.parse(minQntSuperGros.text.trim()),
            }));
        if (response.statusCode == 200) {
          products[updatedProductIndex] =
              _updateProductData(products[updatedProductIndex]);
          addReqState.value = RequestEnum.start;
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
  }

  void deleteProduct(int index) async {
    deleteReqState.value = RequestEnum.waiting;
    try {
      final response = await http.delete(
          Uri.parse(
            AppLinks.deleteProduct,
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': showSearchedUsers
                ? searchedProducts[index].id
                : products[index].id,
          }));
      if (response.statusCode == 200) {
        showSearchedUsers
            ? searchedProducts.removeAt(index)
            : products.removeAt(index);
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

  void loadCategories() async {
    categorieReqState.value = RequestEnum.waiting;
    try {
      final response = await http.get(Uri.parse(AppLinks.getCategories));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['categories'];
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

  ProductModel _updateProductData(ProductModel product) {
    return ProductModel(
        id: product.id,
        name: productName.text.trim(),
        categorirName: categorieValue,
        priceD: double.parse(priceDetailleController.text.trim()),
        priceG: double.parse(priceGrosController.text.trim()),
        priceSG: double.parse(priceSuperGrosController.text.trim()),
        minQntG: int.parse(minQntGros.text.trim()),
        minQntSG: int.parse(minQntSuperGros.text.trim()));
  }
}
