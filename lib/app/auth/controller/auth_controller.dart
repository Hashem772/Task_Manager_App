import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/app/model/user_model.dart';
import 'package:task_manager/main.dart';

import '../../admin/screens/admin_home_screen.dart';
import '../../employee/screens/employee_home_screen.dart';
import '../screens/login_screen.dart';

class AuthController extends GetxController{
  UserModel? user;
  static AuthController get instance => Get.find();
  final _userRef = FirebaseFirestore.instance.collection('Users');
  final _auth = FirebaseAuth.instance;

  Future<bool> checkIsInstall() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    final appInstall = sh.getString('is_install');
    if (appInstall == null) {
      printInfo(info: 'Its First Time To Install App');
      return false;
    }
    return true;
  }

  String get userId => _auth.currentUser!.uid;


 Future<bool> checkUser() async{
   SharedPreferences sh = await SharedPreferences.getInstance();
   final userId = sh.getString('user_id');
   if(userId == null){
     printInfo(info: 'user is null');
     return false;
   }
   final data = await _userRef.doc(userId).get();
   if(data.exists){
     user = UserModel.fromJson(data.data()!);
       return true;
   }
   return false;
//   user = UserModel.fromJson(d.data()!);

//   Get.offAll(MainHome());
 }
/////////////////////////////////////////////////////////
  Future<bool> checkIsAdmin() async{
    SharedPreferences sh = await SharedPreferences.getInstance();
    final userId = sh.getString('user_id');
    if(userId == null){
      printInfo(info: 'user is null');
      return false;
    }
    final data = await _userRef.doc(userId).get();
    if(data.exists){
      user = UserModel.fromJson(data.data()!);
      return true;
    }
    return false;
//   user = UserModel.fromJson(d.data()!);

//   Get.offAll(MainHome());
  }
// //////////////////////////////////////////////////////
  Future<void> signIn(String? email, String? pass) async{
    EasyLoading.show();
    final bool hasInternet = await InternetConnectionChecker().hasConnection;
    if(hasInternet != true) {
      EasyLoading.showError('No Internet connection',duration: Duration(seconds: 2));
     return;
    }
    user=null;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email!,
          password: pass!
      );
      final result = await _userRef.doc(userCredential.user!.uid).get();

      user = UserModel.fromJson(result.data()!);
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString('user_id', user!.userId!);
      gettoken();
      EasyLoading.showSuccess('Success',duration: Duration(seconds: 1));

      if(user!.userType == UserType.ADMIN){
        Get.offAll(()=>AdminHomeScreen());
      }else{
        Get.offAll(()=>EmployeeHomeScreen());
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.showError('Error, user-not-found',duration: Duration(seconds: 2));

      } else if (e.code == 'wrong-password') {
        EasyLoading.showError('Wrong password',duration: Duration(seconds: 2));


      }
    }
  }
  ///////////////////////
  void logout() async{
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);

    try{
      await _auth.signOut();
      Get.offAll(() => LoginScreen());
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.remove('user_id');
      user = null;
      EasyLoading.dismiss();
    }on FirebaseAuthException catch (e) {
       EasyLoading.showToast('${e.code}',duration: Duration(seconds: 2));
    }

  }

  Future<void> changePassword({String? oldPassword, String? newPassword}) async{

  try {
    final cred = await _auth.signInWithEmailAndPassword(
    email: _auth.currentUser!.email!, password: oldPassword!);
    print('${cred.user?.email} useeeeeeer');
    print('${_auth.currentUser?.email} creeeeeeeeeee');
    await _auth.currentUser?.updatePassword(newPassword!);
    //print(e.toString());
  }on FirebaseAuthException catch (e) {
    if(e.code == 'wrong-password'){
      print('wrong-password');
    }else if(e.code == 'weak-password'){
      print('weak-password');

    }
  }
    }

  Future uploadImageToFirebase(File? imageFile) async{
    EasyLoading.show();
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if(hasInternet != true) {
      EasyLoading.showError('No Internet connection');

      return;
    }
    String fileName =  imageFile!.path.split('/').last;
    //print('images/img1.$fileName'+' hashhheeem Fillle');
    final x = await FirebaseStorage.instance.ref().child('images/$fileName').putFile(imageFile);
    EasyLoading.dismiss();
    EasyLoading.showToast('Success, Picture will be change after a few second',duration: Duration(seconds: 2));

    await x.ref.getDownloadURL().then((value) async{
       await _userRef
          .doc(FirebaseAuth.instance.currentUser!.uid).update({'user_image': value});
      /////////
       final result = await _userRef.doc(FirebaseAuth.instance.currentUser!.uid).get();
       user = UserModel.fromJson(result.data()!);
    });

    //var taskSnapshot = await uploadTask.o
  }

  final FirebaseMessaging fcm=  FirebaseMessaging.instance;
  Future<void>? gettoken()async{
    final String? token = await fcm.getToken();
  print('${token} my tokeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen');
      await _userRef.doc(user!.userId).update({'user_token':token});

  }
}
