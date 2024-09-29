import 'package:get/get.dart';
import 'package:market_admin_app/View/Categories%20Page/categories_page.dart';
import 'package:market_admin_app/View/Oders%20Page/orders_page.dart';
import 'package:market_admin_app/View/Products%20Page/products_page.dart';
import '../View/Users Page/users_page.dart';

class HomeController extends GetxController {
  List<String> cards = [
    'Users',
    'Products',
    'Categories',
    'Vos Commandes',
    'Statistiques',
  ];

  void onTap(int index) {
    switch (index) {
      case 0:
        Get.to(() => const UsersPage());
        break;
      case 1:
        Get.to(() => const ProductsPage());
        break;
      case 2:
        Get.to(() => const CategoriesPage());
        break;
      case 3:
        Get.to(() => const OrdersPage());
        break;
    }
  }
}
