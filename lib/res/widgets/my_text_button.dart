import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final bool isLoading;

  const MyTextButton(
      {super.key,
      required this.title,
      this.fontWeight,
      this.fontSize,
      this.color,
      this.backgroundColor,
        this.borderRadius,
      this.width,
      this.height,
      this.padding,
      this.onTap,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator(color: MyColor.whiteColor,) : InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius
      
        ),
        child: MyText(
          title: title,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
