import 'package:BookBin/application/chat_services.dart';
import 'package:BookBin/screens/other_ui/chat_list_page.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatInboxUi extends StatefulWidget {
  ChatInboxUi({
    super.key,
    required this.receiverID,
    required this.receiverName,
    this.requestCheck,
    this.requestMessage,
  });

  bool? requestCheck;
  String? requestMessage;
  final String receiverID;
  final String receiverName;

  @override
  State<ChatInboxUi> createState() => _ChatInboxUiState();
}

class _ChatInboxUiState extends State<ChatInboxUi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController _messagesTextController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  final ChatServices _chatServices = ChatServices();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AppMainColor appColor = AppMainColor();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messageSent();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 200),
          () => scrollToBottom(),
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 200), () => scrollToBottom());
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessages() async {
    if (_messagesTextController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.receiverID, _messagesTextController.text);
    }
    scrollToBottom();
  }

  void messageSent() async {
    if (widget.requestCheck == true) {
      await _chatServices.sendMessage(widget.receiverID, widget.requestMessage!);
      Future.delayed(
        const Duration(milliseconds: 200),
        () => scrollToBottom(),
      );
      widget.requestCheck = false;
      widget.requestMessage = "";
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messagesTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  RxBool isDrawerOpen = false.obs;
  void setDrawerState(bool isOpen) {
    isDrawerOpen.value = isOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_circle_left_rounded,
              size: 40.w, color: Colors.white),
        ),
        title: ListTile(
          title: Text(
            widget.receiverName,
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
          IconButton(
            onPressed: () {
              if (_scaffoldKey.currentState!.isEndDrawerOpen) {
                _scaffoldKey.currentState!.closeEndDrawer();
              } else {
                _scaffoldKey.currentState!.openEndDrawer();
              }
            },
            icon: Icon(Icons.more_vert_rounded, size: 30.w),
          )
        ],
      ),
      body: Scaffold(
        key: _scaffoldKey,
        onDrawerChanged: (isOpen) {
          isDrawerOpen.value = false;
        },
        endDrawer: Align(
          alignment: Alignment.topRight,
          child: SizedBox(
              height: 50.h,
              child: Drawer(
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                width: 200.w,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.w),
                        bottomLeft: Radius.circular(15.w))),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Text(
                                  "Are you sure?",
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await _chatServices.deleteChatRoom(widget.receiverID);
                                      Get.offAll(ChatListPage());
                                    },
                                    icon: Icon(
                                      Icons.check_box,
                                      size: 40.w,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 40.w,
                                      color: Colors.black54,
                                    ))
                              ],
                            ),
                          );
                        });
                  },
                  child: Text(
                    "Delete chat for everyone",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              )),
        ),
        body: ScreenBackground(
          child: Column(
            children: [
              Expanded(child: _buildMessagesList()),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: _focusNode,
                        controller: _messagesTextController,
                        keyboardType: TextInputType.multiline,
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
                          _messagesTextController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          size: 36.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderID = _auth.currentUser?.uid ?? '';
    return SingleChildScrollView(
      reverse: true,
      controller: _scrollController,
      child: StreamBuilder<QuerySnapshot>(
        stream: _chatServices.getMessages(widget.receiverID, senderID),
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
          if (snapshot.data!.docs.isNotEmpty) {
            Future.delayed(
              const Duration(milliseconds: 200),
              () => scrollToBottom(),
            );
          }
          return Column(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
            // itemCount: snapshot.data!.docs.length,
            // itemBuilder: (BuildContext context, int index) {
            //   return _buildMessageItem(snapshot.data!.docs[index]);
            // },
          );
        },
      ),
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
          padding: data?['senderID'] == _auth.currentUser?.uid
              ? EdgeInsets.only(left: 25.w)
              : EdgeInsets.only(right: 25.w),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: data?['senderID'] == _auth.currentUser?.uid ? const Color(0x00000000) : Colors.grey.shade400,
              ),
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
            ),
          ),
        ),
      ),
    );
  }
}
