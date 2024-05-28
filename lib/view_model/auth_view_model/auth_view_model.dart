
import 'package:chatter_box/res/constatnt/constant.dart';
import 'package:chatter_box/view/auth_view/sign_in_view/sign_in_view.dart';
import 'package:chatter_box/view/bottom_navigator_view/bottom_navigator_view.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_bloc/loading_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/loading_bloc/loading_event/loading_event.dart';

class AuthViewModel {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('users');


  /// saving user data while signing
  void saveUserDataWhileSiginIn(String userName , email) async {
    try{
      await _firestore.doc(_auth.currentUser!.uid.toString()).set({
        'userName': userName,
        'joinDate':DateTime.now(),
        'joinFormatedDate': "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        'email': email,
      });
    }catch(error){
      Constant().toastMessage('>>>>> Error while Siginging and saving data $error');
    }
  }

  /// signIn method
  void signIn(BuildContext context, String email, password) async {
    try{
      /// starting loading of button
      context.read<LoadingBloc>().add(SetLoading());
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavigatorView()));
        Constant().toastMessage("Login Successfully");

        /// stopping loading of button
        context.read<LoadingBloc>().add(SetLoading());
      });
    }on FirebaseAuthException catch(error){
      /// stopping loading of button incase of error
      context.read<LoadingBloc>().add(SetLoading());
      Constant().toastMessage(error.message.toString());
    }
  }

  /// SignUp method
  void SignUp(BuildContext context , String email , password , userNmae) async {
    try{
      /// starting loading of button
      context.read<LoadingBloc>().add(SetLoading());

      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        saveUserDataWhileSiginIn(userNmae, email);
        Constant().toastMessage("User Sign in successfully");

        /// stopping loading of button
        context.read<LoadingBloc>().add(SetLoading());

        Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavigatorView()));
      });
    }on FirebaseAuthException catch(error){
      /// stopping loading of button incase of error
      context.read<LoadingBloc>().add(SetLoading());
      Constant().toastMessage(error.message.toString());
    }
  }

  /// signOut method
  void signOut(BuildContext context) async {
    try{
      await _auth.signOut().then((value) {
        Constant().toastMessage('Sign Out Succcessfully');
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
      });
    }on FirebaseAuthException catch(error){
      Constant().toastMessage('>>>>>> Error While Siginging out from AuthViewModel $error');
    }
  }

}