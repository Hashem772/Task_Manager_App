import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/auth/controller/auth_controller.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/shared_widget/Dialogs/error_awesome_dialog.dart';
import 'package:task_manager/app/shared_widget/Dialogs/ask_awesome_dialog.dart';

import '../controller/emp_controller.dart';

class TaskDetails extends StatelessWidget {
  final TaskModel task;
  TaskDetails(this.task);
  @override
  Widget build(BuildContext context) {
    bool isStateZero = true;
    isStateZero = task.getTaskState(AuthController.instance.userId) == 0;

    return WillPopScope(
      onWillPop: () async {
        return !EasyLoading.isShow;
      },
      child: Scaffold(
        backgroundColor: Get.theme.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Get.theme.primaryColor,
          title: Text('Task Details'),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                    margin: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: 'Title: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Get.theme.listTileTheme.textColor),
                                                ),
                                                TextSpan(
                                                  text: '${task.taskTitle}',
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Get.theme.listTileTheme.textColor),
                                                ),
                                              ])),
                                        ),
                                        //SizedBox(height: 14,),
                                        Divider(
                                          height: 4,
                                          thickness: 0.9,
                                          color: Get.theme.listTileTheme.textColor,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context).size.height * 0.02),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: RichText(
                                                        text: TextSpan(children: [
                                                          TextSpan(
                                                              text: 'Details: ',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Get.theme.listTileTheme.textColor,
                                                                  fontSize: 18,
                                                                  wordSpacing: 2,
                                                                  letterSpacing: 0.5)),
                                                          TextSpan(
                                                              text:
                                                              '${task.taskDetails}',
                                                              style: TextStyle(
                                                                  color: Get.theme.listTileTheme.textColor,
                                                                  fontSize: 18,
                                                                  wordSpacing: 1,
                                                                  letterSpacing: 0.5))
                                                        ])),
                                                  ),
                                                  Divider(
                                                    height: 15,
                                                    thickness: 0.9,
                                                    color: Get.theme.listTileTheme.textColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(vertical: 10.0),
                                                    child: Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: RichText(
                                                          text: TextSpan(children: [
                                                            TextSpan(
                                                                text: 'Date: ',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Get.theme.listTileTheme.textColor,
                                                                    fontSize: 18,
                                                                    wordSpacing: 2,
                                                                    letterSpacing: 0.5)),
                                                            TextSpan(
                                                                text: '${task.taskDate}'
                                                                    .toString()
                                                                    .substring(0, 16),
                                                                style: TextStyle(
                                                                  color: Get.theme.listTileTheme.textColor,
                                                                  fontSize: 18,
                                                                ))
                                                          ])),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 17,
                                                    thickness: 0.9,
                                                    color: Get.theme.listTileTheme.textColor,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              )),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Get.theme.primaryColor),
                          child: Text(
                            isStateZero ? 'Receive task' : 'Complete',
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: (){
                            askAwesomeDialog().myDialog(
                                context: context,
                                dialogType: DialogType.question,
                                titleText: isStateZero?'Do you want to receive this task?'
                                    :'Did you finish this task?' ,
                                btnOk: () {

                                  EmpController().updateTaskState(task.taskId!, task.senderId,task.taskTitle! ,isStateZero?1:2,context);
                                  },
                                btnCancel:(){
                                  Get.back();
                                },
                                autoDismiss: false
                            );

                          }

                      ),
                      SizedBox(height: 200,)
                    ],
                  ),
                ),
              ),
            ),

           
          ),
        ),
      ),
    );
  }
}
