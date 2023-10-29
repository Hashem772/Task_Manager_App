import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? taskId;
  String? taskTitle;
  String? taskDetails;
  String? senderId;
//  List<ReceiverModel> receivers = [];
  Map<String, ReceiverModel> empReceivers = {};
  DateTime? taskDate;


  TaskModel({this.taskId,this.taskTitle,this.taskDetails,this.senderId,this.taskDate});

  TaskModel.fromJson(Map<String, dynamic> map, String docId) {
    taskId = docId;
    taskTitle = map['taskTitle'];
    taskDetails = map['taskDetails'];
    senderId = map['senderId'];
    taskDate = map['taskDate'].toDate();
//    if(map['receivers'] != null){
//      receivers = (map['receivers'] as List<dynamic>).map((e) => ReceiverModel.fromJson(e)).toList();
//    }
    if(map['empReceivers'] != null){
       (map['empReceivers'] as Map).forEach((key, value) {
         empReceivers['$key'] = ReceiverModel.fromJson(value);
       });
    }

  }

  int getTaskState(String empId){
    return empReceivers[empId]!.state;
  }

  Map<String, dynamic> toJson() {
    return {
      "taskTitle": taskTitle,
      "taskDetails": taskDetails,
      "senderId": senderId,
//      "receiverId": receiverId,
      "taskDate": FieldValue.serverTimestamp(),
//      "receivers": receivers.map((e) => e.toJson()).toList(),
      "empReceivers": _empReceivers,
    };
  }

  Map get _empReceivers {
    Map result = {};
    empReceivers.forEach((key, value) {
      result[key] = value.toJson();
    });
    return result;
}


}

class ReceiverModel {
  DateTime? finishDate, startDate;
  String? receiverId;
  String? receiverName;
  int state = 0;
  ReceiverModel({this.receiverId,this.receiverName});

  ReceiverModel.fromJson(Map<String, dynamic> map) {
//    receiverId = map['receiverId'];
    finishDate = map['finishDate']?.toDate();
    startDate = map['startDate']?.toDate();
    state = map['state'];
  }

  Map<String, dynamic> toJson() {
    return {
//      "receiverId":  receiverId,
      "state":  state,
      "finishDate": finishDate == null ? null : Timestamp.fromDate(finishDate!) ,
      "startDate": startDate == null ? null : Timestamp.fromDate(startDate!) ,

    };
  }

  String? get getTaskStatus {
    switch (state) {
      case (0):
        return "Not receive";
        break;
      case (1):
        return 'Received';
        break;
      case (2):
        return 'Completed';
        break;
    }
  }
}

