import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar bookListAppBar(
    GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lister name",
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
              size: 15.sp,
            ),
            Text(
              "Sylhet Sadar, Sylhet, Bangladesh",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppMainColor.primaryColor,
              ),
            ),
          ],
        ),
      ],
    ),
    leading: IconButton(
      icon: Icon(
        Icons.person_pin,
        size: 40.sp,
        color: const Color(0xff8847A1),
      ),
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
      },
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: const Color(0xff8847A1),
          size: 32.sp,
        ),
        onPressed: () {
          _bottomSheetWishlist(context);
        },
      ),
      IconButton(
        icon: Icon(
          Icons.notifications,
          color: const Color(0xff8847A1),
          size: 32.sp,
        ),
        onPressed: () {
          scaffoldKey.currentState!.openEndDrawer(); // Open End Drawer
        },
      ),
    ],
  );
}

Future<void> _bottomSheetWishlist(BuildContext context) async {
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

  await showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent.withOpacity(0.8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.sp)),
    ),
    builder: (context) => SizedBox(
      height: 200.h,
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
