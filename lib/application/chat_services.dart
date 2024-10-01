import 'package:BookBin/application/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage(String receiverID, String message) async {
    // Get current user info
   // final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // Retrieve current user's fullName
    final currentUserSnapshot = await _fireStore
        .collection("UserInfo")
        .where("UserUID", isEqualTo: userUID)
        .get();

    // Get current user name
    final String currentUserName = currentUserSnapshot.docs.isNotEmpty
        ? currentUserSnapshot.docs.first["Full_Name"] ?? "SenderName"
        : "SenderName";

    // Retrieve receiver user's fullName
    final receiverUserSnapshot = await _fireStore
        .collection("UserInfo")
        .where("UserUID", isEqualTo: receiverID)
        .get();


    // Get receiver user name
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
      'timestamp': timestamp,
    };

    // Add message to the database
    await _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage);

    // Update chat_rooms metadata with usernames instead of IDs
    await _fireStore.collection("chat_rooms").doc(chatRoomId).set({
      'users': [currentUserName,userUID, receiverUserName,receiverID],
      'lastMessage': message,
      'lastUpdated': timestamp,
    }, SetOptions(merge: true));
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

    // Query to find chat rooms that involve the current user
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
}
