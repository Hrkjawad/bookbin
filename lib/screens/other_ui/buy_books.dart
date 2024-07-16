import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Buttons/backbutton_with_logo.dart';
import '../widgets/Buttons/icon_elevatedbutton.dart';
import '../widgets/Buttons/radio_button.dart';
import '../widgets/TextFields/textformfield_customized.dart';
class BuyBooks extends StatefulWidget {
  const BuyBooks({super.key, required this.bookCost});
  final String bookCost;

  @override
  State<BuyBooks> createState() => _BuyBooksState();
}

class _BuyBooksState extends State<BuyBooks> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _receiverName = TextEditingController();
  final TextEditingController _receivedLocation = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  late double deliveryCharge = 100;
  late double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    late double bookPrice = double.parse(widget.bookCost);
    totalPrice = bookPrice + deliveryCharge;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButtonAndLogo(),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Notice",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "1. Buyers will send the book through Sundarbans Courier Service.\n2. Carefully submit your received location, receiver name and number.\n3. ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff565656),
                      ),
                      children: [
                        TextSpan(
                          text: "Delivery charge 100৳ in Cash on delivery.\n",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.red),
                        ),
                        TextSpan(
                          text:
                              "4. This time only cash on delivery available.\n5. Delivery time from today to next 7 days.",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff565656),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormFieldCustomized(
                  controller: _receiverName,
                  hintText: "Enter receiver name",
                  icon: const Icon(Icons.person),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormFieldCustomized(
                  controller: _phone,
                  hintText: "Enter your phone number",
                  icon: const Icon(Icons.phone),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormFieldCustomized(
                  controller: _receivedLocation,
                  hintText: "Enter your received Location",
                  icon: const Icon(Icons.location_on),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(
                    "Choose your payment option",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: AppMainColor.primaryColor),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.w),
                  child:  RadioButton(
                    nameOption1: 'Cash on delivery',
                    nameOption2: 'Bkash',
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 170.w),
                  child: Column(
                    children: [
                      Text(
                        "Book         :  ${widget.bookCost}  ৳",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff595959),
                        ),
                      ),
                      Text(
                        "Charge      :  $deliveryCharge  ৳",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff595959),
                        ),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: Divider(
                          thickness: 2.h,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Total        :  ${totalPrice.toString()}  ৳",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: IconElevatedButton(
                    text: "Proceed",
                    onPressed: () {
                      Get.snackbar(
                        "Successful",
                        "Your payment was done, within a day you will receive your delivery",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 4),
                      );
                      Get.to(const HomePage());
                    },
                  ),
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
