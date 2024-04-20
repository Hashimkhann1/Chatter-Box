


import 'package:chatter_box/res/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant {

  void toastMessage(String message) async {
    Fluttertoast.showToast(
      msg:message,
      backgroundColor: MyColor.blueColor,
      textColor: MyColor.whiteColor,
    );
  }




}