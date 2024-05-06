import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldCustomized extends StatelessWidget {
  const TextFormFieldCustomized({super.key, required this.keyboardType});
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 182.w,
        height: 40.h,
        child: TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
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
