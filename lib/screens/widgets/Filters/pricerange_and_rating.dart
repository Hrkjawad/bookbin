import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/other_ui_controllers/price_range_and_rating_controller.dart';

class PriceRangeAndRating extends StatelessWidget {
  const PriceRangeAndRating({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PriceRangeAndRatingController());

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: 323.w,
            height: 90.h,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 9.w),
                    child: Row(
                      children: [
                        Text(
                          "Price Range",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Obx(() => Text(
                            "${controller.minPrice.value.toStringAsFixed(0)} - ${controller.maxPrice.value.toStringAsFixed(0)} ৳",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(
                        () => RangeSlider(
                      min: 50,
                      max: 1000,
                      values: controller.values.value,
                      onChanged: (newValues) {
                        controller.updateRangeValues(newValues);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 323.w,
            height: 80.h,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 9.w),
                    child: Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Obx(
                            () => buildStarButton(
                            index + 1,
                            index == 0
                                ? controller.isLiked1.value
                                : index == 1
                                ? controller.isLiked2.value
                                : index == 2
                                ? controller.isLiked3.value
                                : index == 3
                                ? controller.isLiked4.value
                                : controller.isLiked5.value,
                            controller),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget buildStarButton(
      int index, bool isLiked, PriceRangeAndRatingController controller) {
    return GestureDetector(
      onTap: () {
        controller.toggleLike(index);
      },
      child: SizedBox(
        width: 55.w,
        height: 35.h,
        child: Card(
          color: isLiked ? const Color(0xff8847a1) : Colors.grey,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index.toString(),
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              Icon(
                Icons.star,
                size: 16.w,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
