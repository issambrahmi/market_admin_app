import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductsController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? productPic;
  late TextEditingController productName;
  late TextEditingController prixDetailleController;
  late TextEditingController prixGrosController;
  late TextEditingController prixSuperGrosController;

  double prixDetaille = 0.00;
  double prixGros = 0.00;
  double prixSuperGros = 0.00;
  late GlobalKey<FormState> key;
  String userType = 'Boisson';

  @override
  void onInit() {
    productName = TextEditingController();
    prixDetailleController = TextEditingController();
    prixGrosController = TextEditingController();
    prixSuperGrosController = TextEditingController();
    key = GlobalKey<FormState>();
    super.onInit();
  }

  void pickImage() async {
    productPic = await _imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }
}
