import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/view/home_view/all_users_view/all_users_view.dart';
import 'package:chatter_box/view/home_view/recent_update_view/recent_update_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05,),

            //////// Top text field ////////
            Container(
              alignment: Alignment.center,
              height: height * 0.06,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search,color: MyColor.grayColor,),
                  hintText: "Search you chat",
                  hintStyle: TextStyle(
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

            //////// Recent Update Widget ///////
            RecentUpdateView(),
            SizedBox(height: height * 0.01,),

            ////// divider /////
            Divider(color: Colors.grey.shade800,),
            SizedBox(height: height * 0.01,),

            /////// All users ///////
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (context , index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: AllUsersView(),
                  );
                  }),
            )




          ],
        ),
      ),
    );
  }
}
