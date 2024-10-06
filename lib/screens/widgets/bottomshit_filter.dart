import 'package:BookBin/screens/widgets/pricerange_and_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../other_ui/categories_page.dart';
import '../other_ui_controllers/categories_controller.dart';
import '../other_ui_controllers/price_range_and_rating_controller.dart';
import 'Buttons/icon_elevatedbutton.dart';
import 'Categories/categories_booklisting_select.dart';

void bottomSheetFilter(BuildContext context) {
  final PriceRangeAndRatingController controller = Get.find<PriceRangeAndRatingController>();
  final CategoryController controller2 = Get.find<CategoryController>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
    ),
    builder: (BuildContext context) {
      return  Container(
            height: 430.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                const PriceRangeAndRating(),
                SizedBox(height: 20.h),
                CategoriesSelect(),
                IconElevatedButton(
                  text: "Apply",
                  onPressed: () {
                    if (controller.minPrice.value > 0 &&
                        controller.maxPrice.value > 0 &&
                        controller.ratingNumber.value > 0 &&
                        controller2.selectedCategory.isNotEmpty) {
                      Get.offAll(
                            () => CategoriesPage(
                          priceMin: controller.minPrice.value,
                          priceMax: controller.maxPrice.value,
                          rating: controller.ratingNumber.toDouble(),
                          name: controller2.selectedCategory.toString(),
                          collection: controller2.selectedCategory.toString(),
                        ),
                      );
                    } else {
                      Get.snackbar(
                        'Incomplete Filter',
                        'Please select a valid price range, rating, and category.',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                ),
              ],
            ),
          );
      }
  );
}