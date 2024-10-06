import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/pricerange_and_rating.dart';
import '../widgets/recommended_book_card.dart';
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
      endDrawer: const NotificationEndDrawer(),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 32.w, right: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PriceRangeAndRating(),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                     widget. pageName,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  RecommendedBookCardCreate(
                      height: 535.h, collections: widget.collections!, rating: widget.rating ?? 4.5,),
                  SizedBox(
                    height: 16.h,
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
