import 'package:BookBin/screens/other_ui/book_listing.dart';
import 'package:BookBin/screens/other_ui/see_all_page.dart';
import 'package:BookBin/screens/widgets/search_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui_controllers/homepage_controller.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/custom_drawer.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';
import '../widgets/Categories/categories.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/recommended_book_card.dart';
import '../widgets/screen_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  CollectionReference business =
      FirebaseFirestore.instance.collection('Business');
  CollectionReference novels = FirebaseFirestore.instance.collection('Novels');
  CollectionReference health = FirebaseFirestore.instance.collection('Health');
  CollectionReference language =
      FirebaseFirestore.instance.collection('Language');
  CollectionReference science =
      FirebaseFirestore.instance.collection('Science');
  CollectionReference history =
      FirebaseFirestore.instance.collection('History');
  CollectionReference cse = FirebaseFirestore.instance.collection('CSE');
  CollectionReference education =
      FirebaseFirestore.instance.collection('Education');
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(scaffoldKey, context),
      endDrawer: const NotificationEndDrawer(),
      key: scaffoldKey,
      drawer: customDrawer(context),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 32.w, right: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: GetBuilder<HomeController>(
                      builder: (controller) {
                        final greeting = controller.greeting.value;
                        return Text(
                          'Hey, $greeting!',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const SearchFilter(),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  const Categories(
                    minPrice: 0.0,
                    maxPrice: 1000.0,
                    rating: 1.0,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Recommended",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.to(SeeAllPageRecommendedPage(
                            collections: [
                              business,
                              novels,
                              health,
                              language,
                              science,
                              history,
                              cse,
                              education
                            ],
                            pageName: 'Recommended',
                          ));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff6B6B6B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  RecommendedBookCardCreate(
                    height: 265.h,
                    itemCount: 6,
                    collections: [
                      business,
                      novels,
                      health,
                      language,
                      cse,
                      history,
                      science,
                      education
                    ],
                    rating: 4.5,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const BookListing());
                    },
                    child: Center(
                      child: Stack(children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: SizedBox(
                            height: 55.h,
                            width: 211.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              color: const Color(0xff8847a1),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Center(
                                  child: Text(
                                    "List my books",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.add_circle_rounded,
                          color: Colors.white,
                          size: 55.w,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }


}

Widget buildRatingCard(int rating, bool isLiked, Function setState) {
  return SizedBox(
    width: 50.w,
    height: 30.h,
    child: GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
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
              "$rating",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.star,
              size: 14.w,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

// class CategoriesSelectState extends State<CategoriesSelect> {
//   String? selectedName;
//   int selectedIndex = 0;
//   final List<CategoriesList> _categoriesList = [
//     CategoriesList(
//       icon: Icons.science_outlined,
//       isLiked: true,
//       name: "Science",
//     ),
//     CategoriesList(
//       icon: Icons.history_edu_rounded,
//       isLiked: false,
//       name: "History",
//     ),
//     CategoriesList(
//       icon: Icons.business_center_rounded,
//       isLiked: false,
//       name: "Business",
//     ),
//     CategoriesList(
//       icon: Icons.health_and_safety,
//       isLiked: false,
//       name: "Health",
//     ),
//     CategoriesList(
//       icon: Icons.menu_book_sharp,
//       isLiked: false,
//       name: "Novels",
//     ),
//     CategoriesList(
//       icon: Icons.text_fields_outlined,
//       isLiked: false,
//       name: "Language",
//     ),
//     CategoriesList(
//       icon: Icons.computer,
//       isLiked: false,
//       name: "CSE",
//     ),
//     CategoriesList(
//       icon: Icons.school,
//       isLiked: false,
//       name: "Education",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 345.w,
//       height: 100.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: _categoriesList.length,
//         itemBuilder: (context, index) {
//           final item = _categoriesList[index];
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12.w),
//             child: Column(
//               children: [
//                 Card(
//                   color: selectedIndex == index
//                       ? AppMainColor.primaryColor
//                       : Colors.grey,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.w),
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         selectedIndex = index;
//                         selectedName = item.name;
//                       });
//                     },
//                     icon: Icon(
//                       item.icon,
//                       size: 33.w,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   item.name,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CategoriesSelect extends StatefulWidget {
//   const CategoriesSelect({super.key});
//
//   @override
//   CategoriesSelectState createState() => CategoriesSelectState();
// }
//
// class CategoriesList {
//   late bool isLiked;
//   final String name;
//   final IconData icon;
//
//   CategoriesList({
//     required this.isLiked,
//     required this.name,
//     required this.icon,
//   });
// }
