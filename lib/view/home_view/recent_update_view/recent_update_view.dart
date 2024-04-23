import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentUpdateView extends StatelessWidget {
  const RecentUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.013,bottom: height * 0.01,),
          child: MyText(title: 'Recent Update',fontSize: 16,fontWeight: FontWeight.w500,),
        ),
        Container(
          height: height * 0.125,
          // color: Colors.red,
          child: ListView.builder(
              itemCount: MyColor.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context , index) {
                return Column(
                  children: [
                    /////// status image ////
                    Container(
                      width: width * 0.16,
                      height: height * 0.09,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                          color: MyColor.whiteColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: MyColor.blueColor,width: 3.0),
                        image: DecorationImage(
                          image: NetworkImage(MyColor.images[index].toString(),),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    SizedBox(height: height * 0.004,),

                    //// user name ///
                    MyText(title: 'User Name',fontSize: 13,)
                  ],
                );
              }),
        )
      ],
    );
  }
}
