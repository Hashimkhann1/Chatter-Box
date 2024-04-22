import 'package:chatter_box/res/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final Color? hintTextColor;
  final double? fontSize;
  final Widget? prefixIcon;
  final bool obscureText;
  final InputBorder? border;
  final BorderSide enableBorderSide;
  final BorderSide focusedBorderSide;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const MyTextFormField(
      {super.key,
      required this.hintText,
      this.hintTextColor,
      this.fontSize,
      this.prefixIcon,
      this.obscureText = false,
      this.border,
      this.enableBorderSide =
          const BorderSide(color: MyColor.blueColor, width: 2),
      this.focusedBorderSide =
          const BorderSide(color: MyColor.blueColor, width: 2),
      this.validator,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fontSize, color: hintTextColor),
        border: border,
        enabledBorder: UnderlineInputBorder(borderSide: enableBorderSide),
        focusedBorder: UnderlineInputBorder(borderSide: enableBorderSide),
      ),
      validator: validator,
    );
  }
}
