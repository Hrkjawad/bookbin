import 'package:BookBin/application/chat_services.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatInboxUi extends StatelessWidget {
  ChatInboxUi(
      {super.key, required this.receiverID, required this.receiverName, this.requestCheck, this.requestMessage});

   bool? requestCheck;
   String? requestMessage;
  final String receiverID;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _messagesTextController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String receiverName;
  final AppMainColor appColor = AppMainColor();

  void sendMessages() async {
    if (_messagesTextController.text.isNotEmpty) {
      await _chatServices.sendMessage(receiverID, _messagesTextController.text);
      _messagesTextController.clear();
    }
  }
  void messageSent() async{
    if(requestCheck == true){
    await  _chatServices.sendMessage(receiverID, requestMessage!);
    requestCheck =  false;
    requestMessage = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    messageSent();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading:  IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_circle_left_rounded, size: 40.w, color: Colors.white),
        ),
        title: ListTile(
          title: Text(
            receiverName,
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
          subtitle: Text(
            "Online",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.white70),
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.mark_unread_chat_alt, size: 30.w,))
        ],

      ),
      body: ScreenBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(child: _buildMessagesList()),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 55.w,
                    width: 340.w,
                    child: TextFormField(
                      controller: _messagesTextController,
                      style: TextStyle(fontSize: 18.sp),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.w),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.attach_file_rounded,
                            size: 30.w,
                          ),
                        ),
                        hintText: "Type Message",
                        hintStyle: TextStyle(fontSize: 18.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.w),
                          borderSide:
                              BorderSide(color: AppMainColor.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.w),
                          borderSide:
                              BorderSide(color: AppMainColor.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.w),
                    child: IconButton(
                      onPressed: () {
                        sendMessages();
                      },
                      icon: Icon(
                        Icons.send,
                        size: 36.w,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderID = _auth.currentUser?.uid ?? '';
    return StreamBuilder<QuerySnapshot>(
      stream: _chatServices.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet"));
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    String message = data?["message"] ?? "";
    Timestamp timestamp = data?["timestamp"] ?? Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
      child: Align(
        alignment: data?['senderID'] == _auth.currentUser?.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Padding(
          padding: data?['senderID'] == _auth.currentUser?.uid ? EdgeInsets.only(left: 25.w): EdgeInsets.only(right: 25.w),
          child: Container(
              decoration: BoxDecoration(
                color: data?['senderID'] == _auth.currentUser?.uid
                    ? appColor.color[800]
                    : Colors.white70,
                borderRadius: data?['senderID'] == _auth.currentUser?.uid
                    ? BorderRadius.only(
                        topRight: Radius.circular(0.w),
                        topLeft: Radius.circular(15.w),
                        bottomLeft: Radius.circular(15.w),
                        bottomRight: Radius.circular(15.w),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(15.w),
                        topLeft: Radius.circular(0.w),
                        bottomLeft: Radius.circular(15.w),
                        bottomRight: Radius.circular(15.w),
                      ),
              ),
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: data?['senderID'] == _auth.currentUser?.uid
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: data?['senderID'] == _auth.currentUser?.uid
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
