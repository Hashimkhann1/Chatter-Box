import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/view/add_firends_view/add_firends_view.dart';
import 'package:chatter_box/view/call_history_view/call_history_view.dart';
import 'package:chatter_box/view/chat_view/chat_view.dart';
import 'package:chatter_box/view/home_view/home_view.dart';
import 'package:chatter_box/view/profile_view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigatorView extends StatefulWidget {
  const BottomNavigatorView({super.key});

  @override
  State<BottomNavigatorView> createState() => _BottomNavigatorViewState();
}

class _BottomNavigatorViewState extends State<BottomNavigatorView> {
  List allViews = [
    HomeView(),
    CallHistoryView(),
    AddFriendsView(),
    ProfileView(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allViews[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            selectedIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble,color: MyColor.grayColor,),label: "Chat",),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.phone_fill,color: MyColor.grayColor,),label: "Call"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_badge_plus_fill,color: MyColor.grayColor,),label: "Friends"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled,color: MyColor.grayColor,),label: 'Profile'),
        ],
          selectedItemColor: MyColor.whiteColor,
          unselectedItemColor: MyColor.whiteColor,

          selectedLabelStyle: TextStyle(color: Colors.white), // Set selected label color to white
          unselectedLabelStyle: TextStyle(color: Colors.white)
      ),
    );
  }
}
