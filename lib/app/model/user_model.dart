import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? userName;
  String? userToken;
  int? userPhone;
  UserType ?userType ;
  DateTime ?accountDate;
  String? user_image;

  UserModel({this.userId,this.userName, this.userType = UserType.EMPLOYEE,
    this.userToken,this.userPhone,this.accountDate,this.user_image});

  UserModel.fromJson(Map<String, dynamic> map) {
    userId = map['user_id'];
    userName = map['user_name'];
    userPhone = map['user_phone'];
    userType = toUserType((map['user_type']));
    userToken = map['user_token'];
    accountDate = map['accountDate'].toDate();
    user_image = map['user_image'];
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "user_name": userName,
      "user_phone": userPhone,
      "user_type": fromUserType(userType!),
      "user_token": userToken,
      "accountDate": FieldValue.serverTimestamp(),
      "user_image": user_image,
    };
  }

  String? fromUserType(UserType t){
    String result = 'EMPLOYEE';
    switch(t){
      case UserType.ADMIN:
        result = 'ADMIN';
        break;
      case UserType.EMPLOYEE:
        result = 'EMPLOYEE';
        break;
    }
    return result;
  }

  UserType? toUserType(String t){
    UserType? userType;
    switch(t){
      case "ADMIN":
        userType = UserType.ADMIN;
        break;
      case "EMPLOYEE":
        userType = UserType.EMPLOYEE;
        break;
    }
    return userType;
  }
}

enum UserType{
  ADMIN,
  EMPLOYEE,
}


