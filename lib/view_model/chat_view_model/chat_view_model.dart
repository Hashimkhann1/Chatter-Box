

import 'package:chatter_box/res/constatnt/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ChatViewModel {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final Constant constant = Constant();

  final ImagePicker _imagePicker = ImagePicker();


  /// send message method
  // Future sendMessage(BuildContext context , String reciverId , message) async {
  //
  //   try{
  //
  //     final String senderUid = _auth.currentUser!.uid.toString();
  //     final String senderEmail = _auth.currentUser!.email.toString();
  //     final Timestamp timestamp = Timestamp.now();
  //
  //     print(senderUid);
  //     print(reciverId);
  //
  //     await _firestore.doc('${senderUid}_$reciverId').collection('messages').add({
  //       'senderUid': senderUid,
  //       'senderEmail': senderEmail,
  //       'reciverId': reciverId,
  //       'message':message,
  //       'timestamp':timestamp
  //     });
  //   }catch(error){
  //     constant.toastMessage('Unable to send message try again');
  //   }
  // }


  /// send message
  Future<void> sendMessage(String reciverID, message) async {
    try {
      // get currrent user info
      final String currentUserId = _auth.currentUser!.uid.toString();
      final String currentUserEmail = _auth.currentUser!.email.toString();
      final Timestamp timestamp = Timestamp.now();

      // construct chat room ID for the two users (sorted to ensure)
      List<String> ids = [currentUserId, reciverID];
      ids.sort();
      String chatRoomId = ids.join('_');

      // add new message to database
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'senderUid': currentUserId,
        'senderEmail': currentUserEmail,
        'reciverId': reciverID,
        'message':message,
        'timestamp':timestamp
      });
    } catch (error) {
      print(">>>>> error from adding new message");
    }
  }


  /// get message
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct a chatroom ID for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }


  /// pick image
  Future<XFile?> pickImageFromGllery() async {
    final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  }

}