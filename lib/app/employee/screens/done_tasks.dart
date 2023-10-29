import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/shared_widget/not_found_data_screen.dart';

import '../controller/emp_controller.dart';
import 'task_details.dart';

class DoneTasks extends StatelessWidget {
  List<TaskModel> tasks = [];

  final empController = Get.put(EmpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,

        centerTitle: true,
        elevation: 0.0,
        title: Text('Done tasks'),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: StreamBuilder<List<TaskModel>>(
          stream: empController.getEmpTaskByIdStream(2),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }

            ////////////////////
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
                icon: Icons.menu_outlined,
                errorText: 'There are no tasks',
              );
            }
            /////////////////////////
            tasks = snapshot.data!;
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (c, i) {
                  return TaskItem(tasks[i],);
                });
          },
        ),
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
            contentPadding: EdgeInsets.all(10),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Title: ',style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20, color: Get.theme.listTileTheme.textColor
                  ),
                  ),
                  TextSpan(
                    text: '${task.taskTitle!}',style: TextStyle(
                      fontSize: 20,
                    color: Get.theme.listTileTheme.textColor
                  ),
                  )
                ]
              ),
            ),

            subtitle: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: [
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Date of send the task: ',style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Get.theme.listTileTheme.textColor
                        ),
                        ),
                        TextSpan(
                          text: '${task.taskDate.toString().substring(0,11)}',
                          style: TextStyle(
                            fontSize: 16,
                              color: Get.theme.listTileTheme.textColor
                        ),
                        )
                      ]
                  ),
                ),

                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}

