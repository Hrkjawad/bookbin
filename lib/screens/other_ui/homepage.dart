import 'package:BookBin/screens/other_ui/book_listing.dart';
import 'package:BookBin/screens/other_ui/see_all_page_and_categoris_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui_controllers/homepage_controller.dart';
import '../widgets/Categories/categories.dart';
import '../widgets/book_card_create.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/main_appbar.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/screen_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}
class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(scaffoldKey, context),
      body: Scaffold(
        // drawer: const NotificationEndDrawer(),
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
                    Row(
                      children: [
                        SizedBox(
                          width: 296.w,
                          height: 48.h,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Search Textbooks",
                              suffixIcon: Icon(
                                Icons.search,
                                size: 25.w,
                                color: const Color(0xff8847a1),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xff6B6B6B),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 50.w,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  50.w,
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0xff8847a1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15.w,
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0xff8847a1),
                                ),
                              ),
                              filled: true,
                              fillColor: const Color(0XFFFFFFFF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.w),
                          ),
                          color: const Color(0xff8847a1),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.filter_alt_rounded,
                                color: Colors.white,
                                size: 30.w,
                              )),
                        )
                      ],
                    ),
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
                    const Categories(),
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
                            Get.to(const SeeAllPageAndCategorisPage());
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
                    //BookCardCreate( direction: Axis.horizontal,),
                    BookCardCreate(
                      height: 265.h,
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
        endDrawer: const NotificationEndDrawer(),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}


