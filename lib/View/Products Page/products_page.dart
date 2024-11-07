import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_admin_app/Controller/products_controller.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/app_top_section.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/field_validator.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/floating_action_button.dart';
import 'package:market_admin_app/Core/Shared%20Widgets/search_card.dart';
import 'package:market_admin_app/View/Products%20Page/add_new_product_page.dart';
import 'package:market_admin_app/View/Products%20Page/commonW/products_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsController controller = Get.put(ProductsController());
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AppFloatingActionButton(
        onTap: () {
          if (controller.isCategorieLoad == false) {
            controller.loadCategories();
            controller.isCategorieLoad = true;
          }
          if (controller.isAddPage == false) {
            controller.isAddPage = true;
            controller.clearFields();
          }
          Get.to(() => const AddNewProductPage());
        },
        text: 'Add new product',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                AppTopSection(
                  text: 'Products',
                  isUserPage: true,
                  onBackTap: () {
                    if (!controller.showSearchedUsers) {
                      Get.back();
                    } else {
                      controller.showSearchedUsers = false;
                      controller.update();
                    }
                  },
                ),
                SizedBox(height: 15.h),
                SizedBox(height: 60.h),
                const ProductsList(),
              ],
            ),
            SearchCard(
              controller: controller.searchProduct,
              validator: (value) => appValidator(value: value.toString()),
              reqState: controller.searchReqState,
              isNmaesShow: controller.isSearchNmaesShow,
              names: controller.productsNames,
              onTap: () {
                controller.isSearchNmaesShow.value = false;
                controller.showSearchedUsers = true;
                controller.searchedProducts.clear();
                print(controller.searchProduct.text);
                controller.searchForProducts();
              },
            )
          ],
        ),
      ),
    );
  }
}
