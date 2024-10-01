import 'package:BookBin/screens/widgets/wishlist.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar bookListAppBar(scaffoldKey, BuildContext context, String listerName, String listerLocation, [bool wishList = false]) {
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
    leading:  Padding(
      padding:  EdgeInsets.only(left: 8.w),
      child: IconButton(
        onPressed: (){
          Get.back();
        },
        icon: Icon(Icons.arrow_circle_left_rounded, size: 40.w, color: AppMainColor.primaryColor,),
      ),
    ),
    actions: [
      wishList == true ? IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
          size: 40.w,
        ),
        onPressed: () {
          bottomSheetWishlist(context);
        },
      ) : const SizedBox(),
      Padding(
        padding:  EdgeInsets.only(right: 10.w),
        child: IconButton(
          icon: Icon(
            Icons.notifications,
            color: const Color(0xff8847A1),
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
