

import 'package:chatter_box/model/user_data_model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserViewModel {

  final _auth = FirebaseAuth.instance;

  Future getCurrentUserdata() async {
    try{
      DocumentSnapshot<Map<String, dynamic>> getUserData = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).get();
      dynamic userData = await CurrentUserModel.fromJson(getUserData.data()!);
      return userData;
    }catch(error){
      print(">>>>>>> Error while getting current User data from CurrentUserViewModel $error");
    }
  }

}