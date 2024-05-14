import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../welcome_screen.dart';

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
                    Get.to(const WelcomePage());
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
                    _bottomSheetWishlist(context);
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

Future _bottomSheetWishlist(BuildContext context) {
  // Define the Text and Divider variables
  var book1Text = ListTile(
    title: const Center(child: Text('Book 1')),
    onTap: () {
      // Do something when Book 1 is tapped
    },
  );

  var book2Text = ListTile(
    title: const Center(child: Text('Book 2')),
    onTap: () {
      // Do something when Book 2 is tapped
    },
  );

  var divider = const Divider();

  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent.withOpacity(0.8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
    ),
    builder: (context) => SizedBox(
      height: 200,
      child: Column(
        children: [
          book1Text,
          divider,
          book2Text, // Add Book 2 below Book 1
          divider,
          // Add other items as needed
        ],
      ),
    ),
  );
}
