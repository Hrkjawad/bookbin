import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldCustomized extends StatelessWidget {
  const TextFormFieldCustomized({super.key, required this.hintText, required this.icon, required this.keyboardType});
  final String hintText;
  final Widget icon;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350.w,
        height: 51.h,
        child: TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon,
            hintStyle:  TextStyle(
              fontSize: 20.sp,
              color: const Color(0xff6B6B6B),
            ),
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15.w,
              ),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15.w,
              ),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            filled: true,
            fillColor: const Color(0XFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
