import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageChatWidget extends StatelessWidget {
  final dynamic chatData;
  final String reciverId;

  ImageChatWidget({super.key,required this.chatData,required this.reciverId});

  final _auth = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: chatData['senderUid'] != reciverId ? Colors.grey.shade800 : MyColor.blueColor,
          borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(24),
              bottomRight: Radius.circular(_auth.uid.toString() == chatData['senderUid'] ? 0 : 24),
              topLeft: Radius.circular(_auth.uid.toString() != chatData['senderUid'] ? 0 : 22),
              topRight: const Radius.circular(24)
          )),
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: height * 0.27,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: NetworkImage(chatData['imageUrl'].toString()),
          //       fit: BoxFit.cover
          //     ),
          //     borderRadius: BorderRadius.only(
          //         bottomLeft: const Radius.circular(24),
          //         bottomRight: Radius.circular(_auth.uid.toString() == chatData['senderUid'] ? 0 : 24),
          //         topLeft: Radius.circular(_auth.uid.toString() != chatData['senderUid'] ? 0 : 22),
          //         topRight: const Radius.circular(24)
          //     )
          //   ),
          // ),

          ClipRRect(
      borderRadius: BorderRadius.only(
      bottomLeft: const Radius.circular(24),
        bottomRight: Radius.circular(_auth.uid.toString() == chatData['senderUid'] ? 0 : 24),
        topLeft: Radius.circular(_auth.uid.toString() != chatData['senderUid'] ? 0 : 22),
        topRight: const Radius.circular(24)
    ),
            child: FadeInImage(
              placeholder: AssetImage('images/chat_image_loading_2.gif'),
              image: NetworkImage(chatData['imageUrl'].toString()),
            ),
          ),

          // SizedBox(height: height * 0.001,),
          Positioned(
            bottom: 3,
            right: 14,
            child: const Align(
                alignment: Alignment.centerRight,
                child: MyText(title: '9:56 AM',fontSize: 11,fontWeight: FontWeight.bold,)),
          )
        ],
      ),
    );
  }
}
