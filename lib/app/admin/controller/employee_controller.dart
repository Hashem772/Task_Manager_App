import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/model/user_model.dart';
import 'package:task_manager/app/shared_widget/Dialogs/error_awesome_dialog.dart';
import 'package:task_manager/app/shared_widget/Dialogs/ask_awesome_dialog.dart';

import '../../model/task_model.dart';

class EmployeeController extends GetxController {

  final _empRef = FirebaseFirestore.instance.collection("Users");
  final _taskRef = FirebaseFirestore.instance.collection("Tasks");

  List<UserModel> _empData = [];
  List<UserModel> get empData => _empData;

  Future<void> addNewEmployee(String userName ,String userEmail, int phone ,
      String password,BuildContext context) async {
    EasyLoading.show();
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == false)
    {
      EasyLoading.showError('error, No Internet connection !!' ,duration: Duration(seconds: 2));

      return;
    }
    try {
      final Ref = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail, password: password);
      final UserModel userModel = UserModel(
          userName: userName, userPhone: phone,userId: Ref.user!.uid);
      _empRef.doc(Ref.user!.uid).set(userModel.toJson());
     ////
      EasyLoading.dismiss();
      ErrorAwesomeDialog().myDialog(
        context: context,
        dialogType: DialogType.success,
        titleText: 'Success' ,
        autoDismiss: true,

      );

      /////

    } on FirebaseAuthException catch (e) {
      printInfo(info: e.code);
      if(e.code == 'email-already-in-use'){
        EasyLoading.showToast('${e.code}',duration: Duration(seconds: 2));
      }
      if(e.code == 'weak-password'){
        EasyLoading.showToast('${e.code}',duration: Duration(seconds: 2));
      }
    }
  }

  Future<void> addNewTask(TaskModel taskDetails, BuildContext context) async {
    EasyLoading.show();
    final bool result = await InternetConnectionChecker().hasConnection;
    if(result == false)
    {
      EasyLoading.showError('error, No Internet connection !!' ,duration: Duration(seconds: 2));
      return;
    }

    try{
      await  _taskRef.add(taskDetails.toJson());
      ////
      EasyLoading.dismiss();
      ErrorAwesomeDialog().myDialog(
        context: context,
        dialogType: DialogType.success,
        titleText: 'Success' ,
        autoDismiss: true,
      );
      /////
    }catch(e) {
      EasyLoading.showToast('${e}', duration: Duration(seconds: 2));
    }
  }

  bool loading= false;
  Future<void> getAllEmp() async {
    final bool = await InternetConnectionChecker().hasConnection;
    loading = true;
    _empData.clear();
    update();
    final data = await _empRef.where('user_type',isEqualTo: 'EMPLOYEE')
    .orderBy('accountDate', descending: true)
        .get();
    _empData = data.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
    update();
    loading = false;
  }
  UserModel getEmpById(String empId){
    return _empData.firstWhere((element) => element.userId == empId);
  }
  Future<void> serachEmpByName(String? empName) async {
    loading = true;
    update();
    final data = await _empRef.where('user_type',isEqualTo: 'EMPLOYEE')
        .where('user_name',isGreaterThanOrEqualTo: empName)
        //.orderBy('accountDate', descending: true)
        .get();
    _empData = data.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
    _empData = _empData.where((element) => element.userName!.contains(empName!)).toList();
    loading = false;
    update();
  }

}