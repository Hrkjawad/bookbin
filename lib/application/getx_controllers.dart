import 'package:BookBin/screens/other_ui_controllers/price_range_and_rating_controller.dart';
import 'package:get/get.dart';
import '../screens/other_ui_controllers/categories_controller.dart';
import '../screens/other_ui_controllers/homepage_controller.dart';


class GetXBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(PriceRangeAndRatingController());
    Get.put(CategoryController());
  }
}