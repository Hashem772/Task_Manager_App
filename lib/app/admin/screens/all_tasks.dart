
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/admin/screens/task_detail.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/shared_widget/custome_drawer.dart';
import 'package:task_manager/app/shared_widget/task_card.dart';

import '../controller/task_controller.dart';

class AllTasks extends StatelessWidget {
  TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomeDrawer(),
       //backgroundColor: Get.theme.primaryColor,

        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
         // backgroundColor: Get.theme.primaryColor,
          title: Text('All Tasks',),
    ),
      body: SafeArea(
        child: Container(
          padding:  EdgeInsets.only(top: 2,left: 8.0,right: 8.0,bottom: 0.0),

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: StreamBuilder<List<TaskModel>>(
            stream: _taskController.getAllTasks(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(!snapshot.hasData){
                return Text('empty');
              }
              if(snapshot.hasError){
                return Text('error: ${snapshot.error}');
              }
              final taskData = snapshot.data!;
              return ListView.builder(
                  physics: BouncingScrollPhysics(),

                  itemCount: taskData.length,
                  itemBuilder: (c, i) {
                    return InkWell(
                        onTap: (){
                          Get.to(()=> TaskDetail(taskData[i]));
                        },
                        child: TaskCard(taskData[i]));
                  });
            },
          ),
        ),
      ),
    );
  }
}

