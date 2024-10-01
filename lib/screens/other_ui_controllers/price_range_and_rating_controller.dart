import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceRangeAndRatingController extends GetxController {
  var isLiked1 = false.obs;
  var isLiked2 = false.obs;
  var isLiked3 = false.obs;
  var isLiked4 = false.obs;
  var isLiked5 = false.obs;
  var values = const RangeValues(50, 1000).obs;
  var minPrice = "50".obs;
  var maxPrice = "1000".obs;

  void toggleLike(int index) {
    switch (index) {
      case 1:
        isLiked1.value = !isLiked1.value;
        break;
      case 2:
        isLiked2.value = !isLiked2.value;
        break;
      case 3:
        isLiked3.value = !isLiked3.value;
        break;
      case 4:
        isLiked4.value = !isLiked4.value;
        break;
      case 5:
        isLiked5.value = !isLiked5.value;
        break;
    }
  }

  void updateRangeValues(RangeValues newValues) {
    values.value = newValues;
    minPrice.value = newValues.start.toStringAsFixed(0);
    maxPrice.value = newValues.end.toStringAsFixed(0);
  }
}
