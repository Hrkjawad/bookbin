import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../other_ui/categories_page.dart';

class CategoryPage2 extends StatelessWidget {
  const CategoryPage2(
      {super.key, required this.minPrice, required this.maxPrice, required this.rating});

  final double minPrice, maxPrice, rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCard("Novels", Icons.menu_book_sharp),
        _buildSpacer(),
        _buildCard("Language", Icons.text_fields_outlined),
        _buildSpacer(),
        _buildCard("CSE", Icons.computer),
        _buildSpacer(),
        _buildCard("Education", Icons.school),
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