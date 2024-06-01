import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/view_model/auth_view_model/auth_view_model.dart';
import 'package:chatter_box/view_model/bloc/current_user_bloc/current_user_bloc/current_user_bloc.dart';
import 'package:chatter_box/view_model/bloc/current_user_bloc/current_user_state/current_user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: height * 0.12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://e7.pngegg.com/pngimages/348/800/png-clipart-man-wearing-blue-shirt-illustration-computer-icons-avatar-user-login-avatar-blue-child.png',),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: MyColor.whiteColor,
                          child: Icon(CupertinoIcons.camera_fill,color: MyColor.blueColor,size: 21,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  BlocBuilder<CurrentUserBloc , CurrentUserState>(builder: (context , state){
                    print(state.currentUserDataList[0].userName.toString());
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: state.currentUserDataList[0].userName.toString(),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        MyText(
                          title: state.currentUserDataList[0].email.toString(),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: MyColor.grayColor,
                        ),
                      ],
                    );
                  })
                ],
              ),
              SizedBox(height: height * 0.07,),
              const Card(
                  child: ListTile(
                title: MyText(title: 'Edit profile'),
                trailing: Icon(CupertinoIcons.arrow_right),
              )),
              const Card(
                  child: ListTile(
                title: MyText(title: 'Total friends'),
                trailing: MyText(title: '10'),
              )),
              Card(
                  child: ListTile(
                title: const MyText(title: 'Notificatons'),
                trailing: Switch(value: false, onChanged: (value) {},activeColor: MyColor.blueColor,),
              )),
              Card(
                  child: ListTile(
                title: const MyText(title: 'Night Theme'),
                trailing: Switch(value: true, onChanged: (value) {},activeColor: MyColor.blueColor,),
              )),
              Card(
                  child: ListTile(
                    onTap: () {
                      authViewModel.signOut(context);
                    },
                title: const MyText(title: 'Sign Out'),
                trailing: const Icon(Icons.logout),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
