import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/book_card_create.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/main_appbar.dart';
import '../widgets/screen_background.dart';

class SeeAllPageAndCategorisPage extends StatefulWidget {
  const SeeAllPageAndCategorisPage({super.key});
  @override
  State<SeeAllPageAndCategorisPage> createState() => _SeeAllPageAndCategorisPageState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class _SeeAllPageAndCategorisPageState extends State<SeeAllPageAndCategorisPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(scaffoldKey, context),
      body: Scaffold(
        key: scaffoldKey,
        // drawer: NotificationEndDrawer(context),
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, right: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 163.h,
                    ),
                    Text(
                      "Recommended",
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BookCardCreate( height: 564.h,),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
