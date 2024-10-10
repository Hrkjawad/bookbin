import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../other_ui_controllers/homepage_controller.dart';

class NotificationEndDrawer extends StatelessWidget {
  NotificationEndDrawer({super.key});
  final HomeController _userController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 153.h,
        width: 230.w,
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w),
              bottomLeft: Radius.circular(20.w),
            ),
          ),
          child: SingleChildScrollView  (
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.5.w),
                  child: ListTile(
                    onTap: (){
                      showDialog(
                        barrierColor: Colors.transparent,
                          context: (context),
                          builder: (context){
                        return  AlertDialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                           content: Container(
                             decoration: BoxDecoration(
                               color: Colors.white,
                               border: Border.all(color: AppMainColor.primaryColor, width: 2),
                               borderRadius: BorderRadius.circular(25.w),
                             ),
                             width: 500.w,
                             height: 500.h,
                             child: StreamBuilder(
                               stream: FirebaseFirestore.instance.collection("BuyerInfo").snapshots(),
                               builder: (context, snapshot) {
                                 if (snapshot.hasError) {
                                   return const Center(child: Text('Something went wrong'));
                                 }
                                 if (snapshot.connectionState == ConnectionState.waiting) {
                                   return const Center(child: CircularProgressIndicator());
                                 }
                                 final String currentUID = _userController.userUID.toString();
                                 var receiverDocs = snapshot.data?.docs
                                     .where((doc) => doc['receiverUID'] == currentUID)
                                     .toList();
                                 if (receiverDocs != null && receiverDocs.isNotEmpty) {
                                   return _buildList(receiverDocs, isBuyer: false);
                                 } else {
                                   return Center(
                                     child: Padding(
                                       padding: EdgeInsets.all(20.w),
                                       child: Text(
                                         "No books assigned to be delivered by you.",
                                         textAlign: TextAlign.center,
                                         style: TextStyle(
                                             fontSize: 20.sp, color: AppMainColor.primaryColor),
                                       ),
                                     ),
                                   );
                                 }
                               },
                             ),
                           ),
                        );
                      });
                    },
                    title: Text("Seller Request", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: Colors.black
                    ),),
                    leading: Icon(Icons.request_page, size: 25.w, color: AppMainColor.primaryColor,),
                  ),
                ),
                Divider(
                  color: AppMainColor.primaryColor,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.all(4.5.w),
                  child: ListTile(
                    onTap: (){
                      showDialog(
                          barrierColor: Colors.transparent,
                          context: (context),
                          builder: (context){
                            return  AlertDialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: AppMainColor.primaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(25.w),
                                ),
                                width: 500.w,
                                height: 500.h,
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection("BuyerInfo").snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Center(child: Text('Something went wrong'));
                                    }
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
            
                                    final String currentUID = _userController.userUID.toString();
            
                                    var buyerDocs = snapshot.data?.docs
                                        .where((doc) => doc['buyerUID'] == currentUID)
                                        .toList();
                                    if (buyerDocs != null && buyerDocs.isNotEmpty) {
                                      return _buildList(buyerDocs, isBuyer: true);
                                    }else {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(20.w),
                                          child: Text(
                                            "No books bought by you yet",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20.sp, color: AppMainColor.primaryColor),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          });
                    },
                    title: Text("My Cart", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black
                    ),),
                    leading: Icon(Icons.shopping_cart, size: 25.w, color: AppMainColor.primaryColor,),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
  Widget _buildList(List<QueryDocumentSnapshot> docs, {required bool isBuyer}) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: docs.length,
      itemBuilder: (context, int index) {
        final doc = docs[index];
        final bookName = doc['bookName'] ?? "No Book Name";

        DateTime dateTime = doc['timestamp'].toDate() ?? Timestamp.now();
        String formattedTime = DateFormat('h:mm a').format(dateTime);
        String date = DateFormat('d MMMM y').format(dateTime);

        final price = doc['totalPrice'] ?? "";
        final payment = doc['payment'] ?? "";
        final title = isBuyer ? "Bought by me" : "Request for sell";
        return Padding(
          padding: EdgeInsets.all(10.w),
          child: ListTile(
            title: Text(
              bookName,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                  color: AppMainColor.primaryColor
              ),
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                RichText(
                  text: TextSpan(
                      text: "Status      : ",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600, color: Colors.black),
                      children: [
                        TextSpan(
                            text: title,
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black87 ,
                                fontWeight: FontWeight.w600)
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "Price        : ",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600, color: Colors.black),
                      children: [
                        TextSpan(
                            text: "${price.toString()}৳",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black87 ,
                                fontWeight: FontWeight.w600)
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "Date         : ",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600, color: Colors.black),
                      children: [
                        TextSpan(
                            text: date,
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black87 ,
                                fontWeight: FontWeight.w600)
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "Time        : ",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600, color: Colors.black),
                      children: [
                        TextSpan(
                            text: formattedTime,
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black87 ,
                                fontWeight: FontWeight.w600)
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "Payment : ",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600, color: Colors.black),
                      children: [
                        TextSpan(
                            text: payment,
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black87 ,
                                fontWeight: FontWeight.w600)
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 1,
          color: AppMainColor.primaryColor,
        );
      },
    );
  }
}
