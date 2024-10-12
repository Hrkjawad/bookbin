import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../other_ui_controllers/homepage_controller.dart';

HomeController myUID = Get.find<HomeController>();
AppBar bookListAppBar(
    scaffoldKey,
    BuildContext context,
    String listerName,
    String listerLocation,
    String isbn_10,
    String bookPicURL,
    String bookCategory,
    String bookName,
    RxList<RxBool> isLikedList,
    int index) {
  return AppBar(
    key: scaffoldKey,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listerName,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: AppMainColor.primaryColor,
              size: 14.sp,
            ),
            SingleChildScrollView(
              child: Text(
                listerLocation,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppMainColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    leading: Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_circle_left_rounded,
          size: 40.w,
          color: AppMainColor.primaryColor,
        ),
      ),
    ),
    actions: [
      IconButton(
            onPressed: () {
              if (isLikedList[index].value == false) {
                isLikedList[index].value = true;
                Get.snackbar("", "",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    titleText: Text(
                      "Added in your wishlist", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.sp, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    );
                FirebaseFirestore.instance
                    .collection("UserInfo")
                    .doc(myUID.userUID.value)
                    .collection("wishlist")
                    .doc(isbn_10)
                    .set({
                  'Isbn-10': isbn_10,
                  'isLikedList': true,
                  'bookPicURL': bookPicURL,
                  'category': bookCategory,
                  'bookName': bookName,
                });
              } else {
                isLikedList[index].value = false;
                Get.snackbar("", "",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    titleText: Text(
                      "Removed from your wishlist", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.sp, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                   );
                FirebaseFirestore.instance
                    .collection("UserInfo")
                    .doc(myUID.userUID.value)
                    .collection("wishlist")
                    .doc(isbn_10)
                    .delete();
              }
            },
            icon: Icon(
              Icons.favorite,
              size: 40.w,
            ),
            color: Colors.red,
          ),
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: IconButton(
          icon: Icon(
            Icons.notifications,
            color: AppMainColor.primaryColor,
            size: 40.w,
          ),
          onPressed: () {
            scaffoldKey.currentState!.openEndDrawer();
          },
        ),
      ),
    ],
  );
}
