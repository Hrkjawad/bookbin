import '../controllers/other_ui_controllers/price_range_and_rating_controller.dart';
import 'package:get/get.dart';
import '../controllers/other_ui_controllers/homepage_controller.dart';
import '../controllers/other_ui_controllers/categories_controller.dart';
import '../controllers/other_ui_controllers/profile_upload_image_controller.dart';
import '../screens/widgets/Buttons/elevatedbutton_customised.dart';


class GetXBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(PriceRangeAndRatingController());
    Get.put(CategoryController());
    Get.put(FormController());
    Get.put(ProfileController());
  }
}