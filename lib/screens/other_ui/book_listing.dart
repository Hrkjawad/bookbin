import 'package:BookBin/screens/widgets/book_details_textform.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/Categories/categories_booklisting_select.dart';
import '../widgets/textformfield_customized.dart';

class BookListing extends StatefulWidget {
  const BookListing({super.key});

  @override
  State<BookListing> createState() => _BookListingState();
}

class _BookListingState extends State<BookListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20.w),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_circle_left_rounded,
            size: 45.w,
            color: AppMainColor.primaryColor,
          ),
        ),
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 73.h,
              ),
              Center(
                child: Text(
                  "Sell and Swap Your \nBooks",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 38.h,
              ),
              const TextFormFieldCustomized(
                keyboardType: TextInputType.text,
                hintText: "Enter your Book name",
                icon: Icon(Icons.menu_book_rounded),
              ),
              SizedBox(
                height: 31.h,
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.text,
                heading: "Writer Name       :",
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.text,
                heading: "Publisher Name :",
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.text,
                heading: "Edition                 :",
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.number,
                heading: "Release Date      :",
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.text,
                heading: "Language            :",
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.number,
                heading: "ISBN-10               :",
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.number,
                heading: "ISBN-13               :",
              ),
              const BookListingTextFormField(
                keyboardType: TextInputType.number,
                heading: "Stock                   :",
              ),
              SizedBox(height: 24.h,),
              Padding(
                padding:  EdgeInsets.only(left: 35.w),
                child: Text("Select Category",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),),
              ),
              SizedBox(height: 18.h,),
              Padding(
                padding:  EdgeInsets.only(left: 35.w),
                child: const CategoriesSelect(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
