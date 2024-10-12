import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui/book_listing.dart';
import 'bottomshit_filter.dart';

class BookListAndFilter extends StatelessWidget {
  const BookListAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final AppMainColor color = AppMainColor();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(const BookListing());
          },
          child: Center(
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SizedBox(
                  height: 55.h,
                  width: 211.w,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Center(
                        child: Text(
                          "List my books",
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: AppMainColor.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.add_circle_rounded,
                color: color.color[800],
                size: 57.w,
              ),
            ]),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w),
          ),
          color: color.color[800],
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
