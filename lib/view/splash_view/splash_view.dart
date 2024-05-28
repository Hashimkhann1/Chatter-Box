import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/view_model/splash_view_model/splash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final SplashViewModel splashViewModel = SplashViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashViewModel.SplashTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.chat_bubble_2,size: 100,color: MyColor.blueColor,),
            MyText(title: 'Chatter Box',fontSize: 20,fontWeight: FontWeight.bold,)
          ],
        ),
      ),
    );
  }
}
