import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/view/add_firends_view/add_firends_view.dart';
import 'package:chatter_box/view/call_history_view/call_history_view.dart';
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
    const CallHistoryView(),
    const AddFriendsView(),
    ProfileView(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: allViews[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0,bottom: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: MyColor.lightblackColor,

              onTap: (val) {
                setState(() {
                  selectedIndex = val;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.chat_bubble,
                    color: selectedIndex == 0 ? MyColor.blueColor : MyColor.grayColor,
                  ),
                  label: "Chat",
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.phone_fill,
                      color: selectedIndex == 1 ? MyColor.blueColor :  MyColor.grayColor,
                    ),
                    label: "Call"
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.person_badge_plus_fill,
                      color: selectedIndex == 2 ? MyColor.blueColor :  MyColor.grayColor,
                    ),
                    label: "Add Friends"
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.profile_circled,
                      color: selectedIndex == 3 ? MyColor.blueColor :  MyColor.grayColor,
                    ),
                    label: 'Profile'
                ),
              ],
              selectedItemColor: MyColor.whiteColor,
              unselectedItemColor: MyColor.grayColor,
              selectedLabelStyle: const TextStyle(
                  color: Colors.white), // Set selected label color to white
              unselectedLabelStyle: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
