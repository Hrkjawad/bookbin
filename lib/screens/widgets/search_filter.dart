import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottomshit_filter.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 290.w,
          height: 48.h,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Search Textbooks",
              suffixIcon: Icon(
                Icons.search,
                size: 25.w,
                color: const Color(0xff8847a1),
              ),
              hintStyle: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xff6B6B6B),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 50.w,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  50.w,
                ),
                borderSide: const BorderSide(
                  color: Color(0xff8847a1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  15.w,
                ),
                borderSide: const BorderSide(
                  color: Color(0xff8847a1),
                ),
              ),
              filled: true,
              fillColor: const Color(0XFFFFFFFF),
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w),
          ),
          color: const Color(0xff8847a1),
          child: IconButton(
              onPressed: () {
                bottomSheetFilter(context);
              },
              icon: Icon(
                Icons.filter_alt_rounded,
                color: Colors.white,
                size: 30.w,
              )),
        )
      ],
    );
  }
}
