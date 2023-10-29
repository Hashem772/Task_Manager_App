import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/admin/screens/task_detail.dart';
import 'package:task_manager/app/model/user_model.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/shared_widget/not_found_data_screen.dart';
import 'package:task_manager/app/shared_widget/task_card.dart';

import '../controller/task_controller.dart';

class EmpTasksFilter extends StatelessWidget {
  final UserModel empData;
  final int state;
  EmpTasksFilter(this.empData, this.state);
  TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
//    _taskController.getTasksByEmpId(empData.userId!);
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // _taskController.getAllEmp();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: StreamBuilder<List<TaskModel>>(
                stream: _taskController.getEmpTaskByIdStream(empData.userId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return NotFoundDataScreen(
                      icon: Icons.wifi_off_outlined,
                      errorText: 'No internet',
                    );
                  }
                  final taskData = snapshot.data!;
                  if (taskData.isEmpty) {
                    return NotFoundDataScreen(
                      icon: Icons.notes,
                      errorText: 'Emloyee has no task',
                    );
                  }
                  final taskDataFilter = taskData
                      .where((element) =>
                          element.empReceivers['${empData.userId}']?.state ==
                          state)
                      .toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          //physics: BouncingScrollPhysics(),
                          itemCount: taskDataFilter.length,
                          itemBuilder: (c, i) {
                            return InkWell(
                                onTap: () {
                                  Get.to(() => TaskDetail(taskDataFilter[i], emp: empData));
                                },
                                child: TaskCard(taskDataFilter[i]));
                          },
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
