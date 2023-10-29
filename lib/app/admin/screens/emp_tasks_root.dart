import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app/admin/screens/emp_tasks_flter.dart';
import 'package:task_manager/app/employee/screens/task_filter.dart';
import 'package:task_manager/app/model/user_model.dart';

import 'package:task_manager/app/shared_widget/custome_drawer.dart';


class EmpTasksRoot extends StatelessWidget {
  final UserModel _userModel;
  EmpTasksRoot(this._userModel);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(

        child: Scaffold(
            backgroundColor: Get.theme.primaryColor,
            appBar: AppBar(
              backgroundColor: Get.theme.primaryColor,
              centerTitle: true,
              elevation: 0.0,

              title: Text(' ${_userModel.userName} tasks',),
              bottom: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.white),
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey.shade500,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor:  Colors.black,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    child: Text('New Tasks',style: TextStyle(fontSize: 14)),
                  ),
                  Tab(
                    child: Text('Received Tasks',style: TextStyle(fontSize: 14)),
                  ),
                  Tab(
                    child: Text('Finished Tasks',style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            body: TabBarView(

              children: [
                EmpTasksFilter(_userModel,0),
                EmpTasksFilter(_userModel,1),
                EmpTasksFilter(_userModel,2),

              ],
            )
        ),
      ),
    );
  }
}

