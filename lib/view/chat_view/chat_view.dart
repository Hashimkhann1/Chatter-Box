// import 'dart:js';

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
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
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class ChatView extends StatefulWidget {
  final String userName;
  final String reciverId;
  ChatView({super.key,required this.userName,required this.reciverId});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  final _auth = FirebaseAuth.instance.currentUser!;
  final _messageController = TextEditingController();
  final ChatViewModel chatViewModel = ChatViewModel();

  /// sound recoder and player

  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: "audio");
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    if(filePath != null){
    final file = File(filePath);
    print('Recorded file path: $filePath');
    print(file);
    final player = await AudioPlayer();
    player.play();
    // player.play(file as Source);
    }
  }


  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;



    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: MyText(
          title: widget.userName.toString(),
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
                stream: chatViewModel.getMessages(_auth.uid.toString(), widget.reciverId.toString()),
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
                  print('${_auth.uid}_${widget.reciverId}');
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
                              child: data['messageType'] == 'text' ? TextChatWidget(chatData: data,reciverId: widget.reciverId,) : ImageChatWidget(chatData: data, reciverId: widget.reciverId)
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
                          prefixIcon: GestureDetector(
                            onTap: () async {
                              if (recorder.isRecording) {
                                await stopRecorder();
                                setState(() {});
                              } else {
                                await startRecord();
                                setState(() {});
                              }
                            },
                            child: Icon(
                              recorder.isRecording ? Icons.stop : Icons.mic,
                              color: recorder.isRecording ? Colors.red : null,
                            ),
                          ),
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
                        context.read<PickImageBloc>().add(PickImageFromGallery(context: context,reciverId: widget.reciverId));
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
                           await chatViewModel.sendMessage(widget.reciverId, _messageController.text.toString());
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
