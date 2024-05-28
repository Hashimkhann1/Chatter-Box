// import 'dart:js';

import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/view/chat_view/chat_type_widgets/image_chat_widget/image_chat_widget.dart';
import 'package:chatter_box/view/chat_view/chat_type_widgets/text_chat_widget/text_chat_widget.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_bloc/pick_image_bloc.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_event_bloc/pick_image_event_bloc.dart';
import 'package:chatter_box/view_model/chat_view_model/chat_view_model.dart';
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
                  print('${_auth.uid}_$reciverId');
                  print(snapshot.data!.docs.length);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 10),
                      child: snapshot.data!.docs.isEmpty ? const Center(
                        child: MyText(title: 'Message not recieve or sended yet!',fontSize: 17,fontWeight: FontWeight.w700,),
                      ) :  ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            dynamic data = snapshot.data!.docs[index];

                            return Align(
                              alignment: _auth.uid.toString() == data['senderUid']
                                  ? Alignment.bottomRight
                                  : Alignment.centerLeft,
                              child: data['messageType'] == 'text' ? TextChatWidget(chatData: data,reciverId: reciverId,) : ImageChatWidget(chatData: data, reciverId: reciverId)
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
                          prefixIcon: const Icon(Icons.mic),
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
