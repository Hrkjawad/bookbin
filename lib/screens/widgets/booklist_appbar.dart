import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ValueNotifier<bool> isLikedNotifier = ValueNotifier<bool>(false);

AppBar bookListAppBar(GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
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
              size: 14.sp,
            ),
            SingleChildScrollView(
              child: Text(
                "Sylhet Sadar, Sylhet, Bangladesh",
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
      ValueListenableBuilder(
        valueListenable: isLikedNotifier,
        builder: (context, isLiked, child) {
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: isLiked ? Colors.red : Colors.grey,
              size: 32.sp,
            ),
            onPressed: () {
              isLikedNotifier.value = !isLikedNotifier.value;
              _bottomSheetWishlist(context);
            },
          );
        },
      ),
      IconButton(
        icon: Icon(
          Icons.notifications,
          color: const Color(0xff8847A1),
          size: 32.sp,
        ),
        onPressed: () {
          scaffoldKey.currentState!.openEndDrawer();
        },
      ),
    ],
  );
}

Future<void> _bottomSheetWishlist(BuildContext context) async {
  var book1Text = ListTile(
    title: const Center(child: Text('Book 1')),
    onTap: () {},
  );

  var book2Text = ListTile(
    title: const Center(child: Text('Book 2')),
    onTap: () {
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
          book2Text,
          divider,
        ],
      ),
    ),
  );
}
