import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../application/globals.dart';
import '../../../utilitis/app_main_color.dart';
import '../../other_ui_controllers/homepage_controller.dart';
import '../../welcome_screen.dart';

Drawer customDrawer (BuildContext context){
  return Drawer(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60.w, bottom: 15.w),
          child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w),
                color: AppMainColor.primaryColor,
              ),
              height: 80.h,
              width: 80.w,
              child: Icon(
                Icons.person,
                size: 60.w,
                color: Colors.white,
              )),
        ),
        Text(
          userFullName,
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: AppMainColor.primaryColor),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.h,
        ),
        ListTile(
          title: Text(
            userEmail,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          leading: Icon(
            Icons.email_rounded,
            color: AppMainColor.primaryColor,
          ),
        ),
        ListTile(
          title: Text(
            userLocation,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          leading: Icon(
            Icons.location_on_sharp,
            color: AppMainColor.primaryColor,
          ),
        ),
        ListTile(
          title: Text(
            userPhone,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          leading: Icon(
            Icons.phone,
            color: AppMainColor.primaryColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.w, bottom: 25.w),
          child: SizedBox(
            width: 250.w,
            height: 60.h,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w))),
                child: Text(
                  "My Added BookLists",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: AppMainColor.primaryColor),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.w),
          child: SizedBox(
            width: 250.w,
            height: 60.h,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w))),
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: AppMainColor.primaryColor),
                )),
          ),
        ),
        TextButton(
            onPressed: () async {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text("Are you sure?", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600, color: Colors.black), textAlign: TextAlign.center,),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () async{
                        await FirebaseAuth.instance.signOut().then((value) {
                          Get.snackbar("You are successfully logout", "",
                              snackPosition: SnackPosition.BOTTOM);
                          deleteUID();
                          Get.offAll(const WelcomePage());
                        });
                      }, icon:  Icon(Icons.check_box, color: AppMainColor.primaryColor, size: 40.w,)),
                      IconButton(onPressed: () {
                        Get.back();
                      }, icon:  Icon(Icons.cancel, color: Colors.black45, size: 40.w,))
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.w),
                  ),
                );
              });
            },
            child: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red),
              textAlign: TextAlign.center,
            ))
      ],
    ),
  );
}