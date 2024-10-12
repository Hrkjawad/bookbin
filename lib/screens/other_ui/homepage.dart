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
import '../widgets/Appbar_and_BottomNav/notification_end_drawer.dart';
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
      endDrawer:  NotificationEndDrawer(),
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
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  const BookListAndFilter(),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  const Categories(
                    minPrice: 0.0,
                    maxPrice: 1000.0,
                    rating: 5.0,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Recommended",
                        style: TextStyle(
                          fontSize: 28.sp,
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
                            fontSize: 20.sp,
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
                    height: 270.h,
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