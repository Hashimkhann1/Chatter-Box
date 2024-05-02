
import 'dart:io';

import 'package:chatter_box/res/constatnt/constant.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_bloc/loading_bloc.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_event/loading_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      // get current user info
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
        'timestamp':timestamp,
        'messageType' : 'text'
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

  /// uploading chat image
  Future<String?> uploadChatImage(BuildContext context, String chatImage) async {
    try{

      /// starting loading
      context.read<LoadingBloc>().add(SetLoading());

      /// send image in chat with text
      String imageUrl = '';


      File imageFile = File(chatImage);
      final uploadImageRef = FirebaseStorage.instance.ref().child('user/${_auth.currentUser!.uid}');
      await uploadImageRef.putFile(imageFile).then((p0) {
        Constant().toastMessage("Uploading ....");
      }).onError((error, stackTrace) {
        Constant().toastMessage('error while uploading message');
        print('>>>>>> $error');

        /// Stoping loading loadin in case of error
        context.read<LoadingBloc>().add(SetLoading());
      });

      /// getting image url

      imageUrl = await uploadImageRef.getDownloadURL();
      return imageUrl;

    }catch(error) {
      /// Stoping loading loadin in case of error
      context.read<LoadingBloc>().add(SetLoading());

      print('>>>>>>> error while sending image in chat $error');
    }
    return null;

  }

  /// sending chat message
  Future<void> sendChatMessage(BuildContext context, String reciverID, message , chatImage) async {
    try{

      /// getting image url by calling uploadChatImage
      final uploadImageUrl =  await uploadChatImage(context, chatImage);

      /// get current user info
      final String currentUserId = _auth.currentUser!.uid.toString();
      final String currentUserEmail = _auth.currentUser!.email.toString();

      /// current timeStemp
      final Timestamp timestamp = Timestamp.now();

      // construct chat room ID for the two users (sorted to ensure)
      List<String> ids = [currentUserId, reciverID];
      ids.sort();
      String chatRoomId = ids.join('_');

      /// add new chat message to database
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'senderUid': currentUserId,
        'senderEmail': currentUserEmail,
        'reciverId': reciverID,
        'message':message,
        'imageUrl':uploadImageUrl,
        'timestamp':timestamp,
        'messageType' : 'image'
      }).then((value){
        /// stoping loading when message is sended
        context.read<LoadingBloc>().add(SetLoading());

        Navigator.pop(context);
      });

    }catch(error){

      /// stoping loading in case of error
      context.read<LoadingBloc>().add(SetLoading());

      print('>>>>>> error while sendChatMessage from ChatViewModel $error');
      Constant().toastMessage('unable to send image message please try again');
    }
  }

  /// pick image
  Future<XFile?> pickImageFromGallery() async {
    final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  }

}