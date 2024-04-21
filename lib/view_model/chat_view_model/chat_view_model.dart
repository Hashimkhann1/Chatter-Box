

import 'package:chatter_box/res/constatnt/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatViewModel {

  final _firestore = FirebaseFirestore.instance.collection('chat_rooms');
  final _auth = FirebaseAuth.instance;
  final Constant constant = Constant();

  /// send message method
  void sendMessage(BuildContext context , String reciverId , message) async {

    try{

      final String senderUid = _auth.currentUser!.uid.toString();
      final String senderEmail = _auth.currentUser!.email.toString();
      final Timestamp timestamp = Timestamp.now();

      await _firestore.doc('${senderUid}_$reciverId').collection('messages').add({
        'senderUid': senderUid,
        'senderEmail': senderEmail,
        'reciverId': reciverId,
        'message':message,
        'timestamp':timestamp
      });
    }catch(error){
      constant.toastMessage('Unable to send message try again');
    }
  }

}