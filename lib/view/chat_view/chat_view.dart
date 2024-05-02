// import 'dart:js';

import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_bloc/pick_image_bloc.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_event_bloc/pick_image_event_bloc.dart';
import 'package:chatter_box/view_model/chat_view_model/chat_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  final String userName;
  final String reciverId;
  ChatView({super.key,required this.userName,required this.reciverId});

  final _auth = FirebaseAuth.instance.currentUser!;

  final _messageController = TextEditingController();
  final ChatViewModel chatViewModel = ChatViewModel();

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: MyText(
          title: userName.toString(),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.phone_fill,
                color: MyColor.grayColor,
              ))
        ],
        elevation: 0,
        backgroundColor: MyColor.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 6),
        child: Column(
          children: [
            StreamBuilder(
                stream: chatViewModel.getMessages(_auth.uid.toString(), reciverId.toString()),
                builder: (context , snapshot) {
                  if(snapshot.hasError){
                    return const Center(
                      child: CircularProgressIndicator(color: MyColor.whiteColor,),
                    );
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(color: MyColor.whiteColor,),
                    );
                  }
                  print(_auth.uid+'_'+reciverId);
                  print(snapshot.data!.docs.length);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 10),
                      child: snapshot.data!.docs.length == 0 ? const Center(
                        child: MyText(title: 'Message not recieve or sended yet!',fontSize: 17,fontWeight: FontWeight.w700,),
                      ) :  ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            dynamic data = snapshot.data!.docs[index];

                            return Align(
                              alignment: _auth.uid.toString() == data['senderUid']
                                  ? Alignment.bottomRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                decoration: BoxDecoration(
                                    color: snapshot.data!.docs[index]['senderUid'] != reciverId ? Colors.grey.shade800 : MyColor.blueColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: const Radius.circular(24),
                                        bottomRight: Radius.circular(_auth.uid.toString() == data['senderUid'] ? 0 : 24),
                                        topLeft: Radius.circular(_auth.uid.toString() != data['senderUid'] ? 0 : 22),
                                        topRight: const Radius.circular(24)
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      title:
                                      snapshot.data!.docs[index]['message'].toString(),
                                      fontSize: 16,
                                    ),
                                    // SizedBox(height: height * 0.001,),
                                    const Align(
                                      alignment: Alignment.centerRight,
                                        child: MyText(title: '9:56 AM',fontSize: 12,))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }),

            //////// message text field and send button//////
            Container(
              alignment: Alignment.center,
              // width: width,
              // height: height * 0.07,
              decoration: BoxDecoration(
                  color: MyColor.lightblackColor,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                          // prefixIcon: const Icon(
                          //   CupertinoIcons.search,
                          //   color: MyColor.grayColor,
                          // ),
                          hintText: "Type something...",
                          hintStyle:
                          const TextStyle(color: MyColor.grayColor, fontSize: 14),
                          filled: true,
                          fillColor: MyColor.lightblackColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        context.read<PickImageBloc>().add(PickImageFromGallery(context: context,reciverId: reciverId));
                        // if(_messageController.text.isNotEmpty){
                        //    await chatViewModel.sendMessage(reciverId, _messageController.text.toString());
                        //   _messageController.clear();
                        // }
                      },
                      icon: const Icon(CupertinoIcons.photo_on_rectangle)
                  ),
                  IconButton(
                      onPressed: () async {
                        if(_messageController.text.isNotEmpty){
                           await chatViewModel.sendMessage(reciverId, _messageController.text.toString());
                          _messageController.clear();
                        }
                      },
                      icon: const Icon(Icons.send)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
