import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';
import '../widgets/book_card_create.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/pricerange_and_rating.dart';
import '../widgets/screen_background.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.name, required this.collection});
  final String name, collection;

  @override
  State<CategoriesPage> createState() => _SeeAllPageAndCategoriesPageState();
}

class _SeeAllPageAndCategoriesPageState extends State<CategoriesPage> {


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
                      widget.name,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  BookCardCreate(
                    height: 535.h,
                    collections: widget.collection,
                  ),
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
