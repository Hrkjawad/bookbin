import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../other_ui/categories_page.dart';

class CategoryPage1 extends StatelessWidget {
  const CategoryPage1(
      {super.key, required this.minPrice, required this.maxPrice, required this.rating});

  final double minPrice, maxPrice, rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCard("Science", Icons.science_outlined),
        _buildSpacer(),
        _buildCard("History", Icons.history_edu_rounded),
        _buildSpacer(),
        _buildCard("Business", Icons.business_center_rounded),
        _buildSpacer(),
        _buildCard("Health", Icons.health_and_safety),
        _buildSpacer(),
      ],
    );
  }

  Widget _buildCard(String? name, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          color: AppMainColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(CategoriesPage(collection: name.toString(),
                    name: name.toString(),
                    priceMin: minPrice,
                    priceMax: maxPrice,
                    rating: rating,));
                },
                icon: Icon(
                  iconData,
                  size: 33.w,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Text(
          name ?? "No name",
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }


  Widget _buildSpacer() {
    return SizedBox(width: 28.w);
  }

}