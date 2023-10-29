import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/admin/controller/employee_controller.dart';
import 'package:task_manager/app/auth/controller/auth_controller.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/model/user_model.dart';

class TaskDetail extends StatefulWidget {
  final TaskModel task;
  final UserModel? emp;
  TaskDetail(this.task, {this.emp});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  EmployeeController _employeeController = Get.put(EmployeeController());
@override
  void initState() {
  getReceversName();
    super.initState();
  }
  @override
  getReceversName() async{
    if(InternetConnectionChecker().hasConnection == false)return Text('');
    if (widget.emp != null) return SizedBox();
    ///////////////////////////////////
    //widget.task.empReceivers.keys.
    for(var i in widget.task.empReceivers.keys) {
      widget.task.empReceivers['${i}']!.receiverId=i;
          _employeeController.empData.where((element) {
            if(element.userId == i){
              widget.task.empReceivers['${i}']!.receiverName=element.userName;
              return true;
            }
            return false;
      }).toString();

    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Get.theme.primaryColor,
        title: Text('Details'),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
             //color: Get.theme.primaryColor,
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(

                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.8,

                              margin: EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Center(
                                    child: Align(
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
                                              text: '${widget.task.taskTitle}',
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Get.theme.listTileTheme.textColor),
                                            ),
                                          ])),
                                    ),
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
                                                        '${widget.task.taskDetails}',
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
                                                          text: '${widget.task.taskDate}'
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
                                            empInfo(),

                                            taskWorkers(),

                                        ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ),

                        ],
                      ),
                    )),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget empInfo() {
    if (widget.emp == null) return SizedBox();
    final e = widget.task.empReceivers['${widget.emp!.userId}']!;
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text.rich(
              TextSpan(
                  children: [
                    TextSpan(text: '${e.getTaskStatus}',
                      style: TextStyle(
                          color: Get.theme.listTileTheme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),

                    ),
                  ]),
            ),
          ),
          Divider(
            height: 17,
            thickness: 0.9,
            color: Get.theme.listTileTheme.textColor,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text.rich(
              TextSpan(
                  children: [
                    TextSpan(text: 'start date: ' + '${e.startDate?.toString().substring(0,11) ?? "--"}',
                      style: TextStyle(
                          color: Get.theme.listTileTheme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),

                    ),
                  ]),
            ),
          ),
          Divider(
            height: 17,
            thickness: 0.9,
            color: Get.theme.listTileTheme.textColor,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text.rich(
              TextSpan(
                  children: [
                    TextSpan(text: 'finish date: ' + '${e.finishDate?.toString().substring(0,11) ?? "--"}',
                      style: TextStyle(
                          color: Get.theme.listTileTheme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),

                    ),
                  ]),
            ),
          ),


        ]);
  }
  Widget taskWorkers(){
    if (widget.emp != null) return SizedBox();

    return Column(
    children: [
      SizedBox(height: MediaQuery.of(context).size.height *0.05,),
      Align(
        alignment: Alignment.bottomCenter,
        child: Text.rich(
          TextSpan(
              children: [
                TextSpan(text: 'This task was sent to:',
                  style: TextStyle(
                      color: Get.theme.listTileTheme.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),

                ),
              ]),
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height *0.02,),
      Column(
        children: widget.task.empReceivers.values.map((e){
          return Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: 'Name: ',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                        TextSpan(text: '${e.receiverName}',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,

                          ),

                        ),
                      ]),
                )
              ),
              Align(
                  heightFactor: MediaQuery.of(context).size.height *0.0015,
                alignment: Alignment.bottomLeft,
                child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: 'Task statu: ',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                        TextSpan(text: '${e.getTaskStatus}',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,

                          ),

                        ),
                      ]),
                )
              ),
              Align(
                  heightFactor: MediaQuery.of(context).size.height *0.0015,
                  alignment: Alignment.bottomLeft,
                child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: 'Start Date: ',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                        TextSpan(text: '${e.startDate?.toString().substring(0,11) ?? "--"}' +'${e.startDate?.toString().substring(11,16) ?? "--"}',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,

                          ),

                        ),
                      ]),
                )
              ),
              Align(
                  heightFactor: MediaQuery.of(context).size.height *0.0015,

                  alignment: Alignment.bottomLeft,
                child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: 'Finish Date: ',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                        TextSpan(text: '${e.finishDate?.toString().substring(0,11) ?? "--"}' +'${e.finishDate?.toString().substring(11,16) ?? "--"}',
                          style: TextStyle(
                              color: Get.theme.listTileTheme.textColor,
                              fontSize: 18,

                          ),

                        ),
                      ]),
                )
              ),
              Divider(
                height: 17,
                thickness: 0.9,
                color: Get.theme.listTileTheme.textColor,
              ),
            ],
          );
        }).toList(),
      ),
    ],
  );
  }
}
