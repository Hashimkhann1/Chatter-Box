import 'dart:io';
import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_bloc/loading_bloc.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_state/loading_state.dart';
import 'package:chatter_box/view_model/chat_view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowDetailImageView extends StatelessWidget {
  final String imagePath;
  final String reciverId;
  ShowDetailImageView({super.key, required this.imagePath,required this.reciverId});

  final textMessageController = TextEditingController();
  final ChatViewModel chatViewModel = ChatViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: const MyText(title: 'Send Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// image
            SizedBox(
              height: height * 0.78,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: FileImage(File(imagePath)),
                      fit: BoxFit.contain
                )),
              ),
            ),
            SizedBox(height: height * 0.02,),
            /// text form field and send button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.b,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textMessageController,
                      decoration: InputDecoration(
                        hintText: "Write something...",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: MyColor.blueColor),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: MyColor.blueColor),
                            borderRadius: BorderRadius.circular(30)
                        )
                      ),
                    )
                  ),
                  BlocBuilder<LoadingBloc , LoadingState>(builder: (context , state) {
                    return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                            color: state.isLoading ? MyColor.backgroundColor : MyColor.blueColor,
                            shape: BoxShape.circle
                        ),
                        child: state.isLoading ? const CircularProgressIndicator(color: MyColor.blueColor,) : IconButton(onPressed: () {
                          chatViewModel.sendChatMessage(context, reciverId, textMessageController.text, imagePath);
                          // print(textMessageController.text);
                        }, icon: const Icon(Icons.send))
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
