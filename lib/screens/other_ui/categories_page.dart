import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';
import '../widgets/BookCards/book_card_create.dart';
import '../widgets/Appbar_and_BottomNav/notification_end_drawer.dart';
import '../widgets/screen_background.dart';
import '../widgets/Filters/search_filter.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.name, required this.collection, required this.priceMin, required this.priceMax, required this.rating});
  final String name, collection;
  final double priceMin, priceMax, rating;

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
      endDrawer:  NotificationEndDrawer(),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25.h,),
                const BookListAndFilter(),
                SizedBox(height: 25.h,),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                BookCardCreate(
                  height: 535.h,
                  collections: widget.collection, rating: widget.rating, priceMin: widget.priceMin, priceMax: widget.priceMax,
                ),
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
