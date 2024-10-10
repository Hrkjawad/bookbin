import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String userUID = FirebaseAuth.instance.currentUser!.uid;
  // Send message
  Future<void> sendMessage(String receiverID, String message, bool sentMessage) async {
    final Timestamp timestamp = Timestamp.now();

    final currentUserSnapshot = await _fireStore
        .collection("UserInfo")
        .where("UserUID", isEqualTo: userUID)
        .get();

    final String currentUserName = currentUserSnapshot.docs.isNotEmpty
        ? currentUserSnapshot.docs.first["Full_Name"] ?? "SenderName"
        : "SenderName";

    // Retrieve receiver user's fullName
    final receiverUserSnapshot = await _fireStore
        .collection("UserInfo")
        .where("UserUID", isEqualTo: receiverID)
        .get();

    final String receiverUserName = receiverUserSnapshot.docs.isNotEmpty
        ? receiverUserSnapshot.docs.first["Full_Name"] ?? "ReceiverName"
        : "ReceiverName";

    // Create Room ID
    List<String> id = [userUID, receiverID];
    id.sort();
    String chatRoomId = id.join('_');

    // Create new message with metadata
    final newMessage = {
      'senderID': userUID,
      'senderName': currentUserName,
      'receiverID': receiverID,
      'receiverName': receiverUserName,
      'message': message,
      'isSeen': false,
      'timestamp': timestamp,
    };

    // Add message to the database
    await _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage);

    bool newMessages = true;
    // Update chat_rooms metadata with usernames instead of IDs
    await _fireStore.collection("chat_rooms").doc(chatRoomId).set({
      'users': [currentUserName, userUID, receiverUserName, receiverID],
      'lastMessage': message,
      'lastUpdated': timestamp,
      'newMessages': newMessages
    }, SetOptions(merge: true));
  }

  // Delete chat room and all associated messages
  Future<void> deleteChatRoom(String receiverID) async {
    // Create Room ID
    List<String> id = [userUID, receiverID];
    id.sort();
    String chatRoomId = id.join('_');

    // Delete all messages in the chat room
    final messagesSnapshot = await _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .get();

    for (var doc in messagesSnapshot.docs) {
      await doc.reference.delete();
    }

    // Now delete the chat room
    await _fireStore.collection("chat_rooms").doc(chatRoomId).delete();
  }

  Future<void> markMessagesAsSeen(String receiverID) async {
    List<String> id = [userUID, receiverID];
    id.sort();
    String chatRoomId = id.join('_');

    // Get all messages that are sent to the current user and are not yet marked as seen
    final messagesSnapshot = await _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .where("receiverID", isEqualTo: userUID)
        .where("isSeen", isEqualTo: false)
        .get();

    // Mark each of these messages as seen
    for (var doc in messagesSnapshot.docs) {
      await doc.reference.update({'isSeen': true});
    }
  }
  // Get messages stream for a particular chat
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {

    List<String> id = [userID, otherUserID];
    id.sort();
    String chatRoomId = id.join('_');
    return _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();

  }

  // Fetch inbox list based on the current user
  Stream<List<Map<String, dynamic>>> getInboxList() {
    return _fireStore
        .collection("chat_rooms")
        .where("users", arrayContains: userUID)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final chatRoomData = doc.data();
        return chatRoomData;
      }).toList();
    });
  }
  Future<void> updateReadMessage(String userID, String otherUserID) async {
    List<String> id = [userID, otherUserID];
    id.sort();
    String chatRoomId = id.join('_');
    await FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomId).update({
      'newMessages': false,
    });
  }
}