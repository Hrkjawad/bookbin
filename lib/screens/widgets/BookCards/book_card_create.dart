import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:BookBin/screens/other_ui/book_details.dart';

class BookCardCreate extends StatelessWidget {
  const BookCardCreate(
      {super.key,
      required this.height,
      required this.collections,
      required this.rating,
      this.itemCount,
      required this.priceMin,
      required this.priceMax});

  final double height;
  final String collections;
  final int? itemCount;
  final double priceMin, priceMax, rating;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(collections)
          .where('bookPrice', isGreaterThan: priceMin, isLessThan: priceMax)
          .where('bookRating', isLessThanOrEqualTo: rating)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something is wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final documents = snapshot.data!.docs;
        RxList<RxBool> isLikedList =
            List.generate(documents.length, (index) => false.obs).obs;
        if (documents.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Text(
                'No books are available within the price range: ৳${priceMin.toStringAsFixed(0)} - ৳${priceMax.toStringAsFixed(0)} and the rating: $rating',
                style: TextStyle(
                    fontSize: 28.sp,
                    color: AppMainColor.primaryColor,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
            ),
          );
        }
        return SizedBox(
          height: height,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 260,
            ),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = documents[index];
              final data = document.data() as Map<String, dynamic>;

              String imageUrl = data.containsKey("bookPicURL")
                  ? data["bookPicURL"]
                  : "https://i.pinimg.com/736x/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.jpg";

              String bookName =
                  data.containsKey("bookName") ? data["bookName"] : "No Data";

              double bookPrice = data.containsKey("bookPrice")
                  ? data["bookPrice"].toDouble()
                  : 0.0;

              double bookRating = data.containsKey("bookRating")
                  ? data["bookRating"].toDouble()
                  : 0.0;

              String sell = documents[index]['Sell'];
              String swap = documents[index]['Swap'];
              String bookCategory = collections;
              String bookPicURL = documents[index]['bookPicURL'];
              String description = documents[index]['description'];
              String edition = documents[index]['edition'];
              String isbn_10 = documents[index]['isbn_10'];
              String isbn_13 = documents[index]['isbn_13'];
              String language = documents[index]['language'];
              String publisherName = documents[index]['publisherName'];
              String releaseDate = documents[index]['releaseDate'];
              int stock = documents[index]['stock'];
              String writerName = documents[index]['writerName'];
              String listerName = documents[index]['listerName'];
              String listerLocation = documents[index]['listerLocation'];
              String listerUID = documents[index]['listerUID'];
              String listerEmail = documents[index]['listerEmail'];
              return GestureDetector(
                onTap: () {
                  Get.to(BookDetails(
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
                    bookCategory: bookCategory,
                    isLikedList: isLikedList,
                    index: index,
                  ));
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.w),
                            child: Image.network(
                              imageUrl,
                              width: 166.w,
                              height: 217.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   right: 0.w,
                        //   top: 0.h,
                        //   child: Obx(() => IconButton(
                        //         onPressed: () {
                        //           HomeController myUID = Get.find<HomeController>();
                        //           if (isLikedList[index].value == false) {
                        //             isLikedList[index].value = true;
                        //             FirebaseFirestore.instance
                        //                 .collection("UserInfo")
                        //                 .doc(myUID.userUID.value)
                        //                 .collection("wishlist")
                        //                 .doc(isbn_10)
                        //                 .set({
                        //               'Isbn-10': isbn_10,
                        //               'isLikedList': true,
                        //               'bookPicURL' : bookPicURL,
                        //               'category': bookCategory,
                        //               'bookName': bookName
                        //                 });
                        //           } else {
                        //             isLikedList[index].value = false;
                        //             FirebaseFirestore.instance
                        //                 .collection("UserInfo")
                        //                 .doc(myUID.userUID.value)
                        //                 .collection("wishlist")
                        //                 .doc(isbn_10)
                        //                 .delete();
                        //           }
                        //           // isLikedList[index].toggle();
                        //           // document.reference.update({
                        //           //   'isLikedList': isLikedList[index].value,
                        //           // });
                        //         },
                        //         icon: Icon(Icons.favorite),
                        //         color:  isLikedList[index].value
                        //             ? Colors.red
                        //             : Colors.grey,
                        //       )),
                        // ),
                        Positioned(
                          top: 8.h,
                          left: 10.w,
                          child: SizedBox(
                            height: 28.h,
                            child: Card(
                              color: const Color(0xff8847a1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Center(
                                child: Text(
                                  "  ৳ $bookPrice  ",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          right: 11.w,
                          child: SizedBox(
                            width: 55.w,
                            height: 30.h,
                            child: Card(
                              color: const Color(0xff8847a1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bookRating.toString(),
                                    style: TextStyle(
                                        fontSize: 15.sp, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 14.w,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 40.h,
                      child: SingleChildScrollView(
                        child: Text(
                          bookName,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
