import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUserModel {
  String? email;
  Timestamp? joinDate;
  String? joinFormatedDate;
  String? userName;

  CurrentUserModel(
      {this.email, this.joinDate, this.joinFormatedDate, this.userName});

  CurrentUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    joinDate = json['joinDate'];
    joinFormatedDate = json['joinFormatedDate'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['joinDate'] = this.joinDate;
    data['joinFormatedDate'] = this.joinFormatedDate;
    data['userName'] = this.userName;
    return data;
  }
}
