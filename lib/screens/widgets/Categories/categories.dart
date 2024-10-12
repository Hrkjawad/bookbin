import 'package:BookBin/screens/widgets/Categories/category_page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'category_page2.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.minPrice, required this.maxPrice, required this.rating});

  final double minPrice, maxPrice, rating;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late PageController _pageController;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100.h,
          child: PageView(
            controller: _pageController,
            children: [
              CategoryPage1(minPrice: widget.minPrice, maxPrice: widget.maxPrice, rating: widget.rating,),
              CategoryPage2(minPrice: widget.minPrice, maxPrice: widget.maxPrice, rating: widget.rating,),
            ],
          ),
        ),
        SmoothPageIndicator(
            controller: _pageController,  // PageController
            count:  2,
            effect:  const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Color(0xff8847a1)
            ),
        )
      ],
    );
  }
}
