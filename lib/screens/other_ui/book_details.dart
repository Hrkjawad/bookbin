import 'package:BookBin/screens/other_ui/buy_books.dart';
import 'package:BookBin/screens/other_ui/see_all_page_and_categoris_page.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/booklist_appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/screen_background.dart';

class BookDetails extends StatefulWidget {
  BookDetails({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<BookDetails> createState() => _BookDetails();
}

double bookPrice = 100;
double bookRating = 4.5;
String bookName = "The Psychology of Money";
String writerName = "Book Writer";
String bookCategory = "Science";
String publisherName = "Global Brother.";
String edition = "Standard Edition";
String releaseDate = "January 1, 2019";
String language = "English";
String isbn_10 = "1732557101";
String isbn_13 = "978-1732557109";
String stock = "16";
String description =
    "Doing well with money isn’t necessarily about what you know. It’s about how you behave. And behavior is hard to teach, even to really smart people.Money - investing, personal finance, and business decisions - is typically taught as a math-based field, where data and formulas tell us exactly what to do. But in the real world people don’t make financial decisions on a spreadsheet. They make them at the dinner table, or in a meeting room, where personal history, your own unique view of the world, ego, pride, marketing, and odd incentives are scrambled together. In NBSP The Psychology of Money, award-winning author Morgan Housel shares 19 short stories exploring the strange ways people think about money and teaches you how to make better sense of one of life’s most important topics.";


class _BookDetails extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: bookListAppBar(scaffoldKey, context),
      endDrawer: const NotificationEndDrawer(),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 100.w,
                    child: Card(
                      color: AppMainColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.w),
                          bottomRight: Radius.circular(15.w),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "৳ $bookPrice",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const Center(child: ImageSliders()),
                  SizedBox(
                    height: 50.h,
                    width: 100.w,
                    child: Card(
                      color: AppMainColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.w),
                          bottomLeft: Radius.circular(15.w),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "★ $bookRating",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      bookName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "$writerName | $bookCategory",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: const Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(
                          width: 59.w,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    color: AppMainColor.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.w),
                                )),
                            onPressed: () {},
                            child: Text(
                              "Swap",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 26.sp,
                                color: const Color(0xff9C51A8),
                              ),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xff089B31),
                                side: const BorderSide(color: Colors.black),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.w),
                                    bottomLeft: Radius.circular(15.w),
                                  ),
                                )),
                            onPressed: () {
                              Get.to(const BuyBooks());
                            },
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 26.sp,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Publisher Name : $publisherName",
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Edition                 : $edition",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Release Date      : $releaseDate",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Language            : $language",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ISBN-10               : $isbn_10",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ISBN-13               : $isbn_13",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Stock                   : $stock",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: 363.w,
                      height: 170.h,
                      child: SingleChildScrollView(
                        child: Text(
                          textAlign: TextAlign.justify,
                          description,
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class ImageSliders extends StatefulWidget {
  const ImageSliders({super.key});

  @override
  State<ImageSliders> createState() => _ImageSlidersState();
}

class _ImageSlidersState extends State<ImageSliders> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.w),
          child: SizedBox(
            width: 176.w,
            height: 190.h,
            child: PageView(
              controller: _pageController,
              children: [
                Image.network(
                  'https://indobanglabook.s3.us-east-2.amazonaws.com/2109/71g2ednj0JL.jpeg',
                  fit: BoxFit.fill,
                ),
                Image.network(
                  'https://m.media-amazon.com/images/I/61NP3Oa+TSL._SL500_.jpg',
                  fit: BoxFit.fill,
                ),
                // Add more Image.network widgets for additional images
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        SmoothPageIndicator(
          controller: _pageController, // PageController
          count: 2,
          effect: const WormEffect(
              dotColor: Colors.grey, activeDotColor: Color(0xff8847a1)),
        )
      ],
    );
  }
}
