import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:BookBin/screens/other_ui/book_details.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utilitis/app_main_color.dart';

class RecommendedBookCardCreate extends StatelessWidget {
  const RecommendedBookCardCreate({
    super.key,
    required this.height,
    this.itemCount,
    required this.collections,
  });

  final double height;
  final int? itemCount;
  final List<CollectionReference> collections;

  @override
  Widget build(BuildContext context) {
    List<Stream<QuerySnapshot>> streams = [];
    streams.addAll(
      collections.map(
            (collection) => collection
            .where('bookRating', isGreaterThan: 4.5)
            .snapshots(),
      ),
    );
    Stream<List<QuerySnapshot>> combinedStream =
    CombineLatestStream.list(streams);

    return StreamBuilder<List<QuerySnapshot>>(
      stream: combinedStream,
      builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text('Something went wrong. Please try again.'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<DocumentSnapshot> documents = snapshot.data!
            .expand((querySnapshot) => querySnapshot.docs)
            .toList();

        RxList<RxBool> isLikedList = List.generate(documents.length, (index) => false.obs).obs;

        if (documents.isEmpty) {
          return Center(
            child: Text(
              'No books are available',
              style: TextStyle(
                color: AppMainColor.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
              ),
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
            itemCount: itemCount ?? documents.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = documents[index];
              final data = document.data() as Map<String, dynamic>;

              String imageUrl = data.containsKey("bookPicURL") ? data["bookPicURL"] : "https://i.pinimg.com/736x/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.jpg";

              String bookName = data.containsKey("bookName") ? data["bookName"] : "No Data";
              double bookPrice = data.containsKey("bookPrice") ? data["bookPrice"].toDouble() : 0.0;
              double bookRating = data.containsKey("bookRating") ? data["bookRating"].toDouble() : 0.0;

              String bookCategory = collections.firstWhere((collection) => document.reference.path.contains(collection.path.split('/').last),).id;
              String isbn_10 = documents[index]['isbn_10'];
              String bookPicURL = documents[index]['bookPicURL'];

              return GestureDetector(
                onTap: () {
                  Get.to(BookDetails(
                    listerUID: documents[index]['listerUID'],
                    listerEmail: documents[index]['listerEmail'],
                    listerName: documents[index]['listerName'],
                    listerLocation: documents[index]['listerLocation'],
                    sell: documents[index]['Sell'],
                    swap: documents[index]['Swap'],
                    bookPicURL: bookPicURL,
                    description: documents[index]['description'],
                    edition: documents[index]['edition'],
                    isbn_10: isbn_10,
                    isbn_13: documents[index]['isbn_13'],
                    language: documents[index]['language'],
                    publisherName: documents[index]['publisherName'],
                    releaseDate: documents[index]['releaseDate'],
                    stock: documents[index]['stock'],
                    writerName: documents[index]['writerName'],
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
                        //     onPressed: () {
                        //       if (isLikedList[index].value == false) {
                        //         isLikedList[index].value = true;
                        //         FirebaseFirestore.instance
                        //             .collection("UserInfo")
                        //             .doc(myUID.userUID.value)
                        //             .collection("wishlist")
                        //             .doc(isbn_10)
                        //             .set({
                        //           'Isbn-10': isbn_10,
                        //           'isLikedList': true,
                        //           'bookPicURL': bookPicURL,
                        //           'category': bookCategory,
                        //           'bookName': bookName,
                        //         });
                        //       } else {
                        //         isLikedList[index].value = false;
                        //         FirebaseFirestore.instance
                        //             .collection("UserInfo")
                        //             .doc(myUID.userUID.value)
                        //             .collection("wishlist")
                        //             .doc(isbn_10)
                        //             .delete();
                        //       }
                        //     },
                        //     icon: Icon(Icons.favorite),
                        //     color: isLikedList[index].value
                        //         ? Colors.red
                        //         : Colors.grey,
                        //   )),
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
