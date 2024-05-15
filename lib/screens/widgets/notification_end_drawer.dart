import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationEndDrawer extends StatelessWidget {
  const NotificationEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 750.h,
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w),
              bottomLeft: Radius.circular(20.w)),
        ),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Swap Request Chat',
                style: TextStyle(
                    color: AppMainColor.primaryColor, fontSize: 22.sp),
              ),
              onTap: () {},
            ),
            Divider(
              thickness: 2.h,
            ),
            ListTile(
              title: Text(
                'One Book Sell Request',
                style: TextStyle(
                    color: AppMainColor.primaryColor, fontSize: 22.sp),
              ),
              onTap: () {},
            ),
            Divider(
              thickness: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
