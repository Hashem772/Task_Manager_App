import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/auth/controller/auth_controller.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/model/user_model.dart';
import 'package:task_manager/app/services/notification_service.dart';
import 'package:task_manager/app/shared_widget/Dialogs/error_awesome_dialog.dart';

class EmpController extends GetxController{
  final AuthController authController = Get.find<AuthController>();

  final _taskRef = FirebaseFirestore.instance.collection('Tasks');
  final _userRef = FirebaseFirestore.instance.collection('Users');

   final _userId = AuthController.instance.userId;

   Future<void> updateTaskState(String taskId ,String? senderId,String taskTitle,int newState, BuildContext context) async {
     Get.back();
     EasyLoading.show();
     bool result = await InternetConnectionChecker().hasConnection;
     if(result == false)
     {
       EasyLoading.showError('error, No Internet connection !!' ,duration: Duration(seconds: 2));
       return;
     }
    try{
      if(newState == 1){
        await _taskRef.doc(taskId).update({'empReceivers.$_userId.state': newState, 'empReceivers.$_userId.startDate': Timestamp.now()});
      }else{
        await _taskRef.doc(taskId).update({'empReceivers.$_userId.state': newState, 'empReceivers.$_userId.finishDate': Timestamp.now()});
        final result = await _userRef.doc(senderId).get();
        final senderData = UserModel.fromJson(result.data()!);
        await NotificationService().sendPushMessage(
          '${senderData.userToken}',
            '${authController.user!.userName!}',
                'successfully completed the task ($taskTitle) '
        );
      }
      EasyLoading.dismiss();

      ErrorAwesomeDialog().myDialog(
        context: context,
        dialogType: DialogType.success,
        titleText: 'Success' ,
        autoDismiss: true,

      );
    }catch(e){
      EasyLoading.showToast('${e}',duration: Duration(seconds: 2));
    }

   }
   //يجلب البيانات  ويفلتر حسب ال id حق Receiver => الموظف

   Stream<List<TaskModel>> getEmpTaskByIdStream(int state)  {
     return _taskRef.where('empReceivers.$_userId.state', isEqualTo: state)
         /*.orderBy('taskDate',descending: true)*/.snapshots().map((snapshot) {
       return snapshot.docs.map((e) => TaskModel.fromJson(e.data(), e.id)).toList();

     });
   }


   ReceiverModel? getTaskDetailsByReceiverId(List<ReceiverModel> recever){

     for(var element in recever){
       if(element.receiverId == FirebaseAuth.instance.currentUser!.uid){
         return element;
       }
       return null;
     }

   }
}