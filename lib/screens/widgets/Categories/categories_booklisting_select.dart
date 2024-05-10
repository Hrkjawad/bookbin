import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSelect extends StatefulWidget {
  const CategoriesSelect({super.key});

  @override
  CategoriesSelectState createState() => CategoriesSelectState();
}

class CategoriesSelectState extends State<CategoriesSelect> {
  late String _selectedName;
  int _selectedIndex = 0;
  final List<CategoriesList> _categoriesList = [
    CategoriesList(
      icon: Icons.science_outlined,
      isLiked: true,
      name: "Science",
    ),
    CategoriesList(
      icon: Icons.history_edu_rounded,
      isLiked: false,
      name: "History",
    ),
    CategoriesList(
      icon: Icons.business_center_rounded,
      isLiked: false,
      name: "Business",
    ),
    CategoriesList(
      icon: Icons.health_and_safety,
      isLiked: false,
      name: "Health",
    ),
    CategoriesList(
      icon: Icons.menu_book_sharp,
      isLiked: false,
      name: "Novels",
    ),
    CategoriesList(
      icon: Icons.text_fields_outlined,
      isLiked: false,
      name: "Language",
    ),
    CategoriesList(
      icon: Icons.computer,
      isLiked: false,
      name: "CSE",
    ),
    CategoriesList(
      icon: Icons.school,
      isLiked: false,
      name: "Education",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345.w,
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _categoriesList.length,
        itemBuilder: (context, index) {
          final item = _categoriesList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                Card(
                  color: _selectedIndex == index ? AppMainColor.primaryColor : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = index;
                        _selectedName = item.name;
                        if (kDebugMode) {
                          print(_selectedName);
                        }
                      });
                    },
                    icon: Icon(
                      item.icon,
                      size: 33.w,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoriesList {
  late bool isLiked;
  final String name;
  final IconData icon;

  CategoriesList({
    required this.isLiked,
    required this.name,
    required this.icon,
  });
}
