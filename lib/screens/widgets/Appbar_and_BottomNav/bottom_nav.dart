import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../other_ui/chat_list_page.dart';
import '../../other_ui/homepage.dart';
import '../wishlist.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72.h,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 10.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const HomePage());
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.home,
                        size: 30.w,
                        color: const Color(0xff8847A1),
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to( ChatListPage());
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.mark_unread_chat_alt,
                        size: 30.w,
                        color: Colors.blue,
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    bottomSheetWishlist(context);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 30.w,
                        color: const Color(0xff8847A1),
                      ),
                      Text(
                        "Wishlist",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


