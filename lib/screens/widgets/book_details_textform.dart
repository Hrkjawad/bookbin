import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookListingTextFormField extends StatelessWidget {
  const BookListingTextFormField({super.key, required this.keyboardType, required this.heading});
  final TextInputType keyboardType;
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, bottom: 11.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(heading, style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400
          ),),
          SizedBox(width: 16.w,),
          SizedBox(
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
        ],
      ),
    );
  }
}
