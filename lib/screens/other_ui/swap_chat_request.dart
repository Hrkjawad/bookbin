import 'package:BookBin/screens/other_ui/chat_inbox_ui.dart';
import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/booklist_appbar.dart';
import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/bottom_nav.dart';
import 'package:BookBin/screens/widgets/Buttons/elevatedbutton_customised.dart';
import 'package:BookBin/screens/widgets/TextFields/book_details_textform.dart';
import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/notification_end_drawer.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/other_ui_controllers/homepage_controller.dart';

class SwapChatRequest extends StatefulWidget {
  const SwapChatRequest(
      {super.key,
      required this.receiverId,
      required this.receiverEmail,
      required this.bookName,
      required this.bookPicURL,
      required this.receiverName, required this.isbn_10, required this.bookCategory, required this.listerName, required this.listerLocation, required this.isLikedList, required this.index,
      });
  final String receiverId, receiverEmail, bookName, bookPicURL, receiverName;
  final String isbn_10;
  final String bookCategory;
  final String listerName;
  final String listerLocation;
  final RxList<RxBool> isLikedList;
  final int index;

  @override
  State<SwapChatRequest> createState() => _SwapChatRequestState();
}

class _SwapChatRequestState extends State<SwapChatRequest> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _myBookName = TextEditingController();

  final TextEditingController _myLocation = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _myBookName.dispose();
    _myLocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: bookListAppBar(scaffoldKey, context, widget.listerName, widget.listerLocation, widget.isbn_10, widget.bookPicURL, widget.bookCategory, widget.bookName, widget.isLikedList, widget.index),
      endDrawer: NotificationEndDrawer(),
      bottomNavigationBar: const BottomNav(),
      body: ScreenBackground(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 25.h),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.w),
                    child: Image.network(
                      widget.bookPicURL,
                      width: 200.w,
                      height: 200.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(22.w),
                  child: Text(
                    widget.bookName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                BookListingTextFormField(
                  keyboardType: TextInputType.text,
                  controller: _myBookName,
                  heading: 'Your Book Name',
                  validator: (bookName) =>
                      bookName!.length < 5 ? "Please fill this" : null,
                ),
                SizedBox(
                  height: 10.h,
                ),
                BookListingTextFormField(
                  keyboardType: TextInputType.text,
                  controller: _myLocation,
                  heading: 'Your Location     ',
                  validator: (myLocation) =>
                      myLocation!.length < 5 ? "Please fill this" : null,
                ),
                Padding(
                  padding: EdgeInsets.all(25.w),
                  child: Text(
                    "''You can send a message to the person who listed the book and discuss how both of you can arrange to swap your books.''",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ),
                ElevatedButtonCustomised(
                    onPressed: () {
                      HomeController userController = Get.find<HomeController>();
                      final formController = Get.find<FormController>();
                      if (_formKey.currentState!.validate()) {
                        formController.setLoading(false);
                        Get.to(ChatInboxUi(
                          receiverID: widget.receiverId,
                          receiverName: widget.receiverName,
                          requestCheck: true,
                          requestMessage:
                              "Hello ${widget.receiverName}, I’m ${userController.userFullName}.\nI’m interested in exchanging my book:\n *'${_myBookName.text}'*\n\nWith your book:\n*'${widget.bookName}'*.\n\nAnd my location is: ${_myLocation.text}\n\nIf this sounds good to you, let’s discuss the details further. Thank you!",
                        ));
                        _myLocation.clear();
                        _myBookName.clear();
                      }
                      formController.setLoading(false);
                    },
                    text: "Request for Chat"),

              ],
            ),
          ),
        )),
      ),
    );
  }
}
