import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/view/home_view/all_users_view/all_users_view.dart';
import 'package:chatter_box/view/home_view/recent_update_view/recent_update_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final _auth = FirebaseAuth.instance.currentUser!;

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
            SizedBox(
              height: height * 0.05,
            ),

            //////// Top text field ////////
            Container(
              alignment: Alignment.center,
              height: height * 0.06,
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: MyColor.grayColor,
                    ),
                    hintText: "Search you chat",
                    hintStyle:
                        const TextStyle(color: MyColor.grayColor, fontSize: 13),
                    filled: true,
                    fillColor: MyColor.lightblackColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none)),
              ),
            ),

            //////// Recent Update Widget ///////
            const RecentUpdateView(),
            SizedBox(
              height: height * 0.01,
            ),

            ////// divider /////
            Divider(
              color: Colors.grey.shade800,
            ),
            SizedBox(
              height: height * 0.01,
            ),

            /////// All users ///////
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MyColor.whiteColor,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: snapshot.data!.docs[index].id.toString() == _auth.uid.toString() ? const SizedBox() : AllUsersView(
                              userName: snapshot.data!.docs[index]['userName']
                                  .toString(),
                              imagesPath: MyColor.images[index].toString(),
                              reciverId: snapshot.data!.docs[index].id.toString(),
                            ),
                          );
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
