import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSelect extends StatefulWidget {
  const CategoriesSelect({Key? key}) : super(key: key);

  @override
  _CategoriesSelectState createState() => _CategoriesSelectState();
}

class _CategoriesSelectState extends State<CategoriesSelect> {
  late String selectedName;
  List<CategoriesList> categoriesList = [
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
      icon: Icons.health_and_safety_rounded,
      isLiked: false,
      name: "Health",
    ),
    CategoriesList(
      icon: Icons.menu_book_sharp,
      isLiked: false,
      name: "Science",
    ),
    CategoriesList(
      icon: Icons.text_fields_outlined,
      isLiked: false,
      name: "Business",
    ),
    CategoriesList(
      icon: Icons.computer,
      isLiked: false,
      name: "Health",
    ),
    CategoriesList(
      icon: Icons.school,
      isLiked: false,
      name: "Science",
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
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          final item = categoriesList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                Card(
                  color: item.isLiked ? const Color(0xff8847a1) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if(item.isLiked = !item.isLiked)
                          {
                            selectedName = item.name;
                            print(selectedName);
                          }
                        else
                        {
                          selectedName = "";
                          print(selectedName);
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
