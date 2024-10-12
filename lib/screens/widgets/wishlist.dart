import 'package:BookBin/screens/other_ui_controllers/homepage_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utilitis/app_main_color.dart';
import '../other_ui/book_details.dart';

Future<void> bottomSheetWishlist(BuildContext context) {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  HomeController myUID = Get.find<HomeController>();

  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent.withOpacity(0.8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
    ),
    builder: (context) => SizedBox(
      height: 500,
      child: StreamBuilder(
        stream: firebaseFirestore
            .collection("UserInfo")
            .doc(myUID.userUID.value)
            .collection("wishlist")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              'You are not selected any book as a favourite',
              style: TextStyle(fontSize: 18.sp),
            ));
          }
          List<DocumentSnapshot> wishlistDocuments = snapshot.data!.docs;

          return ListView.separated(
            itemCount: wishlistDocuments.length,
            itemBuilder: (context, index) {
              String bookName = wishlistDocuments[index]['bookName'] ?? '';
              String bookPicURL = wishlistDocuments[index]['bookPicURL'] ?? '';
              String category = wishlistDocuments[index]['category'] ?? '';
              String isbn_10 = wishlistDocuments[index]['Isbn-10'] ?? '';
              RxList<RxBool> isLikedList =
                  List.generate(wishlistDocuments.length, (index) => false.obs)
                      .obs;
              return Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
                  onTap: () {
                    FirebaseFirestore firebase = FirebaseFirestore.instance;
                    firebase
                        .collection(category)
                        .where('isbn_10', isEqualTo: isbn_10)
                        .limit(1)
                        .get()
                        .then((snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        var documents = snapshot.docs.first;
                        double bookPrice = documents["bookPrice"].toDouble();
                        double bookRating = documents["bookRating"].toDouble();
                        String sell = documents['Sell'];
                        String swap = documents['Swap'];
                        String bookPicURL = documents['bookPicURL'];
                        String description = documents['description'];
                        String edition = documents['edition'];
                        String isbn_10 = documents['isbn_10'];
                        String isbn_13 = documents['isbn_13'];
                        String language = documents['language'];
                        String publisherName = documents['publisherName'];
                        String releaseDate = documents['releaseDate'];
                        int stock = documents['stock'];
                        String writerName = documents['writerName'];
                        String listerName = documents['listerName'];
                        String listerLocation = documents['listerLocation'];
                        String listerUID = documents['listerUID'];
                        String listerEmail = documents['listerEmail'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetails(
                              listerUID: listerUID,
                              listerEmail: listerEmail,
                              listerName: listerName,
                              listerLocation: listerLocation,
                              sell: sell,
                              swap: swap,
                              bookPicURL: bookPicURL,
                              description: description,
                              edition: edition,
                              isbn_10: isbn_10,
                              isbn_13: isbn_13,
                              language: language,
                              publisherName: publisherName,
                              releaseDate: releaseDate,
                              stock: stock,
                              writerName: writerName,
                              bookPrice: bookPrice,
                              bookRating: bookRating,
                              bookName: bookName,
                              bookCategory: category,
                              isLikedList: isLikedList,
                              index: index,
                            ),
                          ),
                        );
                      } else {
                        Get.snackbar(
                            isbn_10, 'No matching book found for this ISBN',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    }).catchError((error) {
                      Get.snackbar('Failed to fetch book data', "",
                          snackPosition: SnackPosition.BOTTOM);
                    });
                  },
                  title: Text(
                    bookName,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  subtitle: Text(
                    category,
                    style: TextStyle(
                        color: AppMainColor.primaryColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  leading: ClipOval(
                      child: Image.network(
                    bookPicURL,
                    fit: BoxFit.fill,
                    width: 60.h,
                    height: 70.h,
                  )),
                  trailing: IconButton(
                      onPressed: () {
                        isLikedList[index].value = false;
                        Get.snackbar(
                          "",
                          "",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          titleText: Text(
                            "Removed from your wishlist",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                        FirebaseFirestore.instance
                            .collection("UserInfo")
                            .doc(myUID.userUID.value)
                            .collection("wishlist")
                            .doc(isbn_10)
                            .delete();
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )),
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
        },
      ),
    ),
  );
}
