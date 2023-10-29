import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/employee/controller/emp_controller.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/shared_widget/not_found_data_screen.dart';

import 'task_details.dart';

class TaskFilter extends StatelessWidget {
  final int stateNumber;
  TaskFilter(this.stateNumber);
  List<TaskModel> tasks = [];

  final empController = Get.put(EmpController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
        child: StreamBuilder<List<TaskModel>>(
          stream: empController.getEmpTaskByIdStream(stateNumber),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: Get.theme.primaryColor,));
            }

            final bool result = InternetConnectionChecker().hasConnection == true;
            if (result == false && snapshot.hasData == false) {
              return NotFoundDataScreen(
                icon: Icons.wifi_off_outlined,
                errorText: 'No internet connection',
              );
            }
             if(snapshot.hasError){
              return Center(child: Text('error: ${snapshot.error}'));
            }
            if (snapshot.hasData == false) {
              return NotFoundDataScreen(
                icon: Icons.person_off,
                errorText: 'There is no task',
              );
            }
             tasks = snapshot.data!;
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (c, i) {
                  return TaskItem(tasks[i],);
                });
          },
        ),
      );
  }
}
class TaskItem extends StatelessWidget {
  final TaskModel task;
  TaskItem(this.task,);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
     Get.to(()=> TaskDetails(task));
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Get.theme.primaryColor.withRed(100),width: 2)),
          //color:Colors.white,
          child: ListTile(

            title: Text('${task.taskTitle!}',style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20
            ),),
            subtitle: Column(

              children: [

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(task.taskDate.toString().substring(0,11),
                      style: TextStyle(fontSize: 16)),
                ),

              ],
            ),

          ),
        ),
      ),
    );
  }
}

