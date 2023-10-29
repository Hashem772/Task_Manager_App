import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/model/user_model.dart';

class TaskController extends GetxController {

  final _taskRef = FirebaseFirestore.instance.collection("Tasks");

  List<TaskModel> _taskData = [];
  List<TaskModel> get taskData => _taskData;



  bool loading = false;

  Stream<List<TaskModel>> getEmpTaskByIdStream(String empId)  {
    return _taskRef.where('empReceivers.$empId.state', isGreaterThanOrEqualTo: 0).snapshots().map((snapshot) {
      return snapshot.docs.map((e) => TaskModel.fromJson(e.data(), e.id)).toList();
    });
  }

  Stream<List<TaskModel>> getAllTasks()  {
    return _taskRef.snapshots().map((snapshot) {
      return snapshot.docs.map((e) => TaskModel.fromJson(e.data(), e.id)).toList();
    }
    );
  }


}