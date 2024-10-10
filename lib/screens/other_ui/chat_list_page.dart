//import 'package:BookBin/application/notification_services.dart';
import 'package:BookBin/screens/other_ui/chat_inbox_ui.dart';
import 'package:BookBin/screens/other_ui_controllers/homepage_controller.dart';
import 'package:BookBin/screens/widgets/Appbar_and_BottomNav/custom_drawer.dart';
import 'package:BookBin/screens/widgets/notification_end_drawer.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../application/chat_services.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ChatServices _chatServices = ChatServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer(context),
      appBar: mainAppBar(scaffoldKey, context),
      endDrawer: NotificationEndDrawer(),
      body: ScreenBackground(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _chatServices.getInboxList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading inbox list"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No chats available"));
            }
            // Get the list of chat documents
            var chatList = snapshot.data!;

            return ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                chatList.sort((a, b) {
                  Timestamp aTime = a['lastUpdated'] ?? Timestamp.now();
                  Timestamp bTime = b['lastUpdated'] ?? Timestamp.now();
                  return bTime.compareTo(aTime); // For latest messages at the top
                });

                var chatData = chatList[index];
                List<dynamic> users = chatData['users'];
                bool newMessages = chatData['newMessages'] ?? false;
                String lastMessage = chatData['lastMessage'] ?? '';
                Timestamp lastUpdated =
                    chatData['lastUpdated'] ?? Timestamp.now();

                String currentUserID = _auth.currentUser?.uid ?? '';
                int currentUserIndex =
                    users.indexWhere((user) => user == currentUserID);

                // Determine the other user's name based on the index
                String otherUserName, receiverID;
                if (currentUserIndex == 1) {
                  // If the current user is the first sender
                  otherUserName = users[2]; // Receiver's name
                  receiverID = users[3];
                } else if (currentUserIndex == 3) {
                  // If the current user is the second sender
                  otherUserName = users[0]; // Sender's name
                  receiverID = users[1];
                } else {
                  otherUserName = "";
                  receiverID = "";
                }
                // if(users.indexWhere((user) => user == currentUserID) == 3 && newMessages == true){
                //   NotificationServices.showNotification(
                //     id: chatData.hashCode,
                //     title: 'Message from $otherUserName',
                //     body: lastMessage,
                //   );
                // }
                return Padding(
                  padding: EdgeInsets.only(top: 15.w),
                  child: _buildChatListItem(
                      otherUserName,
                      lastMessage,
                      lastUpdated,
                      receiverID,
                      currentUserIndex,
                      newMessages,
                      users,
                      currentUserID),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  Widget _buildChatListItem(
      String otherUserName,
      String lastMessage,
      Timestamp lastUpdated,
      String receiverID,
      int currentUserIndex,
      bool newMessages,
      List users,
      String currentUserID) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(25.w)
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.w,
            backgroundColor: AppMainColor.primaryColor,
            child: Text(
              otherUserName[0],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          title: Text(
            otherUserName,
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            lastMessage,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          trailing: Wrap(
            children: [
              Text(
                _formatTimestamp(lastUpdated),
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              SizedBox(
                width: 10.w,
              ),
              users.indexWhere((user) => user == currentUserID) == 3 &&
                      newMessages == true
                  ? Icon(
                      Icons.circle,
                      color: AppMainColor.primaryColor,
                      size: 20.w,
                    )
                  : SizedBox(),
            ],
          ),
          onTap: () {
            final userID = Get.find<HomeController>();
            if(users.indexWhere((user) => user == currentUserID) == 3){
              _chatServices.updateReadMessage(userID.userUID.value, receiverID);
            }
            Get.to(ChatInboxUi(
              receiverID: receiverID,
              receiverName: otherUserName,
            ));
          },
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }
}
