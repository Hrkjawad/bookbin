import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonCustomised extends StatelessWidget {
  const ElevatedButtonCustomised({super.key, required this.onPressed, required this.text});
final VoidCallback onPressed;
final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 60.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.w),
        )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
