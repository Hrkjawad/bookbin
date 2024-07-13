import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:BookBin/screens/other_ui/book_details.dart';

class BookCardCreate extends StatefulWidget {
  const BookCardCreate({super.key, required this.height});

  final double height;

  @override
  State<BookCardCreate> createState() => _BookCardCreateState();
}

class _BookCardCreateState extends State<BookCardCreate> {
  late List<bool> isLikedList;

  @override
  void initState() {
    super.initState();
    isLikedList = List.filled(10, false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Business").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          height: widget.height,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 260,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Get.to(BookDetails());
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
                              document["bookPicURL"],
                              width: 166.w,
                              height: 217.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12.w,
                          top: 8.h,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLikedList[index] = !isLikedList[index];
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color: isLikedList[index] ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          left: 10.w,
                          child: SizedBox(
                            width: 65.w,
                            height: 28.h,
                            child: Card(
                              color: const Color(0xff8847a1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Center(
                                child: Text(
                                  "${document["bookPrice"]} ৳",
                                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          right: 11.w,
                          child: SizedBox(
                            width: 50.w,
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
                                    document["bookRating"].toString(),
                                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
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
                          document["bookName"],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 16.sp),
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
