import 'package:get/get.dart';

class CategoryController extends GetxController {
  var selectedCategory = ''.obs;
  var selectedIndex = 10.obs;

  void updateCategory(String category, int index) {
    selectedCategory.value = category;
    selectedIndex.value = index;
  }
}