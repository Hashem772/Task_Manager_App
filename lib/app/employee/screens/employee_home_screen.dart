import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager/app/shared_widget/custome_drawer.dart';

import 'task_filter.dart';

class EmployeeHomeScreen extends StatefulWidget {
  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
 @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(

        child: Scaffold(
          endDrawer: CustomeDrawer(),
        // backgroundColor: Get.theme.primaryColor,
            appBar: AppBar(
             // backgroundColor: Get.theme.primaryColor,
              centerTitle: true,
              elevation: 0.0,

              title: Text('Tasks',),
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
                    child: Text('New Tasks',style: TextStyle(fontSize: 18)),
                  ),
                  Tab(
                    child: Text('Received',style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
            body: TabBarView(

              children: [
                TaskFilter(0),
                TaskFilter(1),

              ],
            )
        ),
      ),
    );
  }
}

