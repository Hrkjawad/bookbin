import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {

  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.h,
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
                        style: TextStyle(fontSize: 16.sp, color: Colors.black,),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //chat
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
                    //Get.to(() => pagename );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 30.w,
                        color: const Color(0xff8847A1),
                      ),
                      Text(
                        "Resources",
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