import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app/shared_widget/custome_drawer.dart';

import 'all_tasks.dart';
import 'employees_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();

}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int currentIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* endDrawer: CustomeDrawer(),
      appBar: AppBar(

      ),*/

      body: IndexedStack(

      children: [
          EmployeesScreen(),
          AllTasks(),


        ],
        index: currentIndex,
      ),

      bottomNavigationBar: ConvexAppBar.badge(

        {0:"",1:''},
         height:kBottomNavigationBarHeight * 1.0,

        items: [

          TabItem(
           // backgroundColor: Colors.purple.shade400,


            icon: Icon(Icons.people,color:Get.theme.bottomNavigationBarTheme.unselectedIconTheme!.color,
              size: Get.theme.bottomNavigationBarTheme.unselectedIconTheme!.size,),
            title:'Employees',
            activeIcon: Icon(Icons.people,color: Get.theme.bottomNavigationBarTheme.selectedIconTheme!.color,
              size:  Get.theme.bottomNavigationBarTheme.selectedIconTheme!.size,),
          ),
          TabItem(

            icon: Icon(Icons.menu,color:Get.theme.bottomNavigationBarTheme.unselectedIconTheme!.color,
              size: Get.theme.bottomNavigationBarTheme.unselectedIconTheme!.size,),
            title:'Tasks',
            activeIcon: Icon(Icons.menu,color: Get.theme.bottomNavigationBarTheme.selectedIconTheme!.color,
              size:  Get.theme.bottomNavigationBarTheme.selectedIconTheme!.size,),

          ),
        ],
        initialActiveIndex: currentIndex,
        onTap: (n){
          setState(() {

            currentIndex=n;

          });
        },

        backgroundColor: Get.theme.bottomNavigationBarTheme.backgroundColor
        //activeColor: Get.theme.colorScheme.secondary,


      ),
    );
  }

}
