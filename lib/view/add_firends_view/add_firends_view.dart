import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/res/widgets/my_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFriendsView extends StatelessWidget {
  const AddFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03,),
              const MyText(title: "Add new friends",fontSize: 18,fontWeight: FontWeight.w600,),
              SizedBox(height: height * 0.02,),

              //////// search friends text field ////////
              Container(
                alignment: Alignment.center,
                height: height * 0.06,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.search,color: MyColor.grayColor,),
                      hintText: "Search you friends with name",
                      hintStyle: const TextStyle(
                          color: MyColor.grayColor,
                          fontSize: 13
                      ),
                      filled: true,
                      fillColor: MyColor.lightblackColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),
              
              Expanded(
                child: GridView.builder(
                  itemCount: MyColor.images.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 1/0.4
                    ),
                    itemBuilder: (context , index) {
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: MyColor.lightblackColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade900,
                                blurRadius: 8,
                                // spreadRadius: 2
                              )
                            ]
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(radius: 24,backgroundImage: NetworkImage(MyColor.images[index].toString(),)),
                              SizedBox(width: width * 0.03,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MyText(title: 'User Name',fontSize: 17,fontWeight: FontWeight.w600,),
                                  MyTextButton(title: 'Add',fontSize: 15,fontWeight: FontWeight.w600, backgroundColor: MyColor.blueColor,padding: EdgeInsets.symmetric(horizontal: 10),)
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )

            ],
          ),
        ),
      ),
    );
  }
}
