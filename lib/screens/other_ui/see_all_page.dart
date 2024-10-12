import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/custom_drawer.dart';
import 'package:BookBin/screens/widgets/Filters/search_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';
import '../widgets/Appbar_and_BottomNav/notification_end_drawer.dart';
import '../widgets/BookCards/recommended_book_card.dart';
import '../widgets/screen_background.dart';

class SeeAllPageRecommendedPage extends StatefulWidget {
   const SeeAllPageRecommendedPage(
      {super.key, required this.collections, required this.pageName, this.rating});
  final List<CollectionReference>? collections;
  final String pageName;
  final double? rating;

  @override
  State<SeeAllPageRecommendedPage> createState() =>
      _SeeAllPageAndCategoriesPageState();
}

class _SeeAllPageAndCategoriesPageState
    extends State<SeeAllPageRecommendedPage> {

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(scaffoldKey, context,),
      key: scaffoldKey,
      drawer: customDrawer(context),
      endDrawer: NotificationEndDrawer(),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25.h,),
                const BookListAndFilter(),
                SizedBox(height: 25.h,),
                Text(
                 widget. pageName,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                RecommendedBookCardCreate(
                    height: 535.h, collections: widget.collections!,),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
