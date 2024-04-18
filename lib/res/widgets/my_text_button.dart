import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const MyTextButton({super.key,required this.title,this.fontWeight,this.fontSize,this.color,this.backgroundColor,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: MyText(title: title,fontWeight: fontWeight,fontSize: fontSize,color: color,),
    );
  }
}
