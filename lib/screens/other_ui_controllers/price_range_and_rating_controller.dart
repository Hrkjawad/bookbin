import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceRangeAndRatingController extends GetxController {
  var isLiked1 = false.obs;
  var isLiked2 = false.obs;
  var isLiked3 = false.obs;
  var isLiked4 = false.obs;
  var isLiked5 = false.obs;
  var ratingNumber = 0.obs;
  var values = const RangeValues(50, 1000).obs;
  var minPrice = 50.0.obs;
  var maxPrice = 1000.0.obs;
  void toggleLike(int index) {
    isLiked1.value = index == 1;
    isLiked2.value = index == 2;
    isLiked3.value = index == 3;
    isLiked4.value = index == 4;
    isLiked5.value = index == 5;
    ratingNumber.value = index;
  }

  void updateRangeValues(RangeValues newValues) {
    values.value = newValues;
    minPrice.value = newValues.start;
    maxPrice.value = newValues.end;
  }
}
