import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: MyText(
          title: 'User Name',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
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
            /////// messages ///////

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 10),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: index % 2 == 1
                            ? Alignment.bottomRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: width * 0.70,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: index % 2 == 1 ? MyColor.blueColor : Colors.grey.shade800,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(index % 2 == 1 ? 0 : 20),
                                topLeft: Radius.circular(index % 2 == 0 ? 0 : 20),
                                topRight: Radius.circular(20)
                              )),
                          child: MyText(
                            title:
                                'This is the user message from both sender and reciver and ohter thing this is what saoainkb',
                            fontSize: 16,
                          ),
                        ),
                      );
                    }),
              ),
            ),

            //////// message text field and send button//////
            Container(
              alignment: Alignment.center,
              width: width,
              height: height * 0.07,
              decoration: BoxDecoration(
                color: MyColor.lightblackColor,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type something...",
                          fillColor: MyColor.lightblackColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none
                          )
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.send)
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
