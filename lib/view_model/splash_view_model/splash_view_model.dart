


import 'dart:async';

import 'package:chatter_box/view/auth_view/sign_in_view/sign_in_view.dart';
import 'package:chatter_box/view/bottom_navigator_view/bottom_navigator_view.dart';
import 'package:chatter_box/view_model/bloc/current_user_bloc/current_user_bloc/current_user_bloc.dart';
import 'package:chatter_box/view_model/bloc/current_user_bloc/current_user_event/current_user_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewModel {

  final _auth = FirebaseAuth.instance.currentUser;

  void SplashTime(BuildContext context)  {

    Timer(const Duration(seconds: 2) , () {
      context.read<CurrentUserBloc>().add(CurrentUserData());
      Navigator.push(context, MaterialPageRoute(builder: (context) => _auth != null ? const BottomNavigatorView() : SignInView() ));
    });
  }

}