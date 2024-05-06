import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar mainAppBar(GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: ListTile(
      title: Text(
        "Your Name",
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        "yourname@gmail.com",
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xff8847A1),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.person_pin,
          size: 32.w,
          color: const Color(0xff8847A1),
        ),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      trailing: const Icon(
        Icons.notifications_active,
        color: Color(0xff8847A1),
        size: 32,
      ),
    ),
  );
}
