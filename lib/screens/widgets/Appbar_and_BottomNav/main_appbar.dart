import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../application/globals.dart';

AppBar mainAppBar(GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: ListTile(
      title: Text(
        userFullName,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        userEmail,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xff8847A1),
        ),
      ),
    ),
    leading: IconButton(
      icon: CircleAvatar(
        child: Icon(
          Icons.person,
          size: 30.w,
        ),
      ),
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
      },
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.notifications,
          color: const Color(0xff8847A1),
          size: 35.w,
        ),
        onPressed: () {
          scaffoldKey.currentState!.openEndDrawer();
        },
      ),
    ],
  );
}
