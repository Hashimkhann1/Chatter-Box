import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextChatWidget extends StatelessWidget {
  final dynamic chatData;
  final String reciverId;
  TextChatWidget({super.key,required this.chatData,required this.reciverId});

  final _auth = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    // print(chatData['senderUid']);
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(left: 12,right: 8,top: 6),
      decoration: BoxDecoration(
          color: chatData['senderUid'] != reciverId ? Colors.grey.shade800 : MyColor.blueColor,
          borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(14),
              bottomRight: Radius.circular(_auth.uid.toString() == chatData['senderUid'] ? 0 : 14),
              topLeft: Radius.circular(_auth.uid.toString() != chatData['senderUid'] ? 0 : 14),
              topRight: const Radius.circular(14)
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title:
            chatData['message'].toString(),
            fontSize: 16,
          ),
          // SizedBox(height: height * 0.001,),
          const Align(
              alignment: Alignment.centerRight,
              child: MyText(title: '9:56 AM',fontSize: 12,))
        ],
      ),
    );
  }
}
