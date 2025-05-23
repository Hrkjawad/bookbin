import 'package:BookBin/screens/other_ui/buy_books.dart';
import 'package:BookBin/screens/other_ui/swap_chat_request.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/Appbar_and_BottomNav/booklist_appbar.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/notification_end_drawer.dart';
import '../widgets/screen_background.dart';

class BookDetails extends StatefulWidget {
  const BookDetails(
      {super.key,
      required this.sell,
      required this.swap,
      required this.bookPicURL,
      required this.description,
      required this.edition,
      required this.isbn_10,
      required this.isbn_13,
      required this.language,
      required this.publisherName,
      required this.releaseDate,
      required this.stock,
      required this.writerName,
      required this.bookPrice,
      required this.bookRating,
      required this.bookName,
      required this.bookCategory,
      required this.listerName,
      required this.listerLocation,
      required this.listerUID,
      required this.listerEmail,
      required this.isLikedList,
      required this.index});
  final String sell;
  final String swap;
  final String bookName;
  final String bookCategory;
  final String bookPicURL;
  final String description;
  final String edition;
  final String isbn_10;
  final String isbn_13;
  final String language;
  final String publisherName;
  final String releaseDate;
  final int stock;
  final String writerName;
  final double bookPrice;
  final double bookRating;
  final String listerName;
  final String listerLocation;
  final String listerUID;
  final String listerEmail;
  final RxList<RxBool> isLikedList;
  final int index;

  @override
  State<BookDetails> createState() => _BookDetails();
}

class _BookDetails extends State<BookDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String userUID = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: bookListAppBar(
          scaffoldKey,
          context,
          widget.listerName,
          widget.listerLocation,
          widget.isbn_10,
          widget.bookPicURL,
          widget.bookCategory,
          widget.bookName,
          widget.isLikedList,
          widget.index),
      endDrawer: NotificationEndDrawer(),
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
                          "৳ ${widget.bookPrice}",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Center(
                      child: ImageSliders(
                    bookPicURL: widget.bookPicURL,
                  )),
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
                          "★ ${widget.bookRating}",
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
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: Text(
                        widget.bookName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "${widget.writerName} | ${widget.bookCategory}",
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
                        widget.listerUID == userUID
                            ? Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Text("This is added by me",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                ),
                              )
                            : const SizedBox(),
                        widget.swap == "Yes" && widget.listerUID != userUID
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                        color: AppMainColor.primaryColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.w),
                                    )),
                                onPressed: () {
                                  Get.to(SwapChatRequest(
                                    receiverId: widget.listerUID,
                                    receiverEmail: widget.listerEmail,
                                    bookName: widget.bookName,
                                    bookPicURL: widget.bookPicURL,
                                    receiverName: widget.listerName,
                                    listerLocation: widget.listerLocation,
                                    listerName: widget.listerName,
                                    isbn_10: widget.isbn_10,
                                    isLikedList: widget.isLikedList,
                                    index: widget.index,
                                    bookCategory: widget.bookCategory,
                                  ));
                                },
                                child: Text(
                                  "Swap",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 26.sp,
                                    color: const Color(0xff9C51A8),
                                  ),
                                ))
                            : const SizedBox(),
                        widget.listerUID != userUID
                            ? ElevatedButton(
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
                                  Get.to(BuyBooks(
                                    bookCost: widget.bookPrice,
                                    name: widget.bookName,
                                    bookPicURL: widget.bookPicURL,
                                    listerUID: widget.listerUID,
                                  ));
                                },
                                child: Text(
                                  "Buy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 26.sp,
                                    color: Colors.white,
                                  ),
                                ))
                            : const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Publisher Name : ${widget.publisherName}.",
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
                          "Edition                 : ${widget.edition}",
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
                          "Release Date      : ${widget.releaseDate}",
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
                          "Language            : ${widget.language}",
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
                          "ISBN-10               : ${widget.isbn_10}",
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
                          "ISBN-13               : ${widget.isbn_13}",
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
                          "Stock                   : ${widget.stock.toString()}",
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
                      //height: 170.h,
                      child: Text(
                        textAlign: TextAlign.justify,
                        widget.description,
                        style: TextStyle(
                          fontSize: 20.sp,
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
  const ImageSliders({super.key, required this.bookPicURL});
  final String bookPicURL;
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
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      barrierColor: Colors.transparent,
                      PhotoView(
                        imageProvider: NetworkImage(widget.bookPicURL),
                      ),
                    );
                  },
                  child: Image.network(
                    widget.bookPicURL,
                    fit: BoxFit.fill,
                  ),
                ),
                Image.network(
                  'https://nomore.org.au/sites/default/files/logo-fb.png',
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
