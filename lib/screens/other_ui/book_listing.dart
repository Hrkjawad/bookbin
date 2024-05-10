import 'package:BookBin/screens/widgets/book_details_textform.dart';
import 'package:BookBin/screens/widgets/bottom_nav.dart';
import 'package:BookBin/screens/widgets/elevatedbutton_customised.dart';
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
  bool? _isSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon:  Icon(
          Icons.arrow_circle_left_rounded,
          size: 45.w,
          color: AppMainColor.primaryColor,
        ),
        )
      ),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                SizedBox(height: 30.h),
                const TextFormFieldCustomized(
                  keyboardType: TextInputType.text,
                  hintText: "Enter your Book name",
                  icon: Icon(Icons.menu_book_rounded),
                ),
                SizedBox(height: 30.h),
                const BookListingDetails(),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Select Category",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 18.h,
                ),
                const CategoriesSelect(),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 345.w,
                  child: descriptionTextField,
                ),
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  "Upload Images",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 80.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  "Do you want to swap your books?",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: true,
                      groupValue: _isSelected,
                      onChanged: (value) {
                        setState(() {
                          _isSelected = value;
                        });
                      },
                    ),
                    Text(
                      'Yes',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Radio(
                      value: false,
                      groupValue: _isSelected,
                      onChanged: (value) {
                        setState(() {
                          _isSelected = value;
                        });
                      },
                    ),
                    Text(
                      'No',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36.h,
                ),
                const TextFormFieldCustomized(
                    hintText: "Enter Location for swap books",
                    icon: Icon(Icons.location_on),
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 36.h,
                ),
                Stack(
                  children: [
                    ElevatedButtonCustomised(onPressed: () {}, text: "Submit"),
                    Positioned(
                        right: 0,
                        child: Icon(
                          Icons.arrow_circle_right_rounded,
                          size: 60.w,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

TextFormField get descriptionTextField {
  return TextFormField(
    keyboardType: TextInputType.multiline,
    maxLines: null,
    decoration: InputDecoration(
        hintText: "Enter minimum 150 words description.",
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(
          fontSize: 18.sp,
          color: const Color(0xff6B6B6B),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.w),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.w),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        )),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter some text.';
      }
      int wordCount = value.split(' ').where((word) => word.isNotEmpty).length;
      if (wordCount < 150) {
        return 'Minimum 150 words required.';
      }
      return null;
    },
  );
}

class BookListingDetails extends StatelessWidget {
  const BookListingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BookListingTextFormField(
          keyboardType: TextInputType.text,
          heading: "Writer Name       :",
        ),
        BookListingTextFormField(
          keyboardType: TextInputType.text,
          heading: "Publisher Name :",
        ),
        BookListingTextFormField(
          keyboardType: TextInputType.text,
          heading: "Edition                 :",
        ),
        BookListingTextFormField(
          keyboardType: TextInputType.number,
          heading: "Release Date      :",
        ),
        BookListingTextFormField(
          keyboardType: TextInputType.text,
          heading: "Language            :",
        ),
        BookListingTextFormField(
          keyboardType: TextInputType.number,
          heading: "ISBN-10               :",
        ),
        BookListingTextFormField(
          keyboardType: TextInputType.number,
          heading: "ISBN-13               :",
        ),
        BookListingTextFormField(
          keyboardType: TextInputType.number,
          heading: "Stock                   :",
        ),
      ],
    );
  }
}
