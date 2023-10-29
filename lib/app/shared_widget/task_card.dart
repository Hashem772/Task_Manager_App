import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app/model/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  TaskCard(this.task);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Get.theme.primaryColor,width: 2)),
        //color:Colors.white,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: Text('${task.taskTitle}',style: TextStyle(fontWeight: FontWeight.bold,
                color: Get.theme.listTileTheme.tileColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 18
            ))
          ),
          subtitle: Align(
            alignment: Alignment.bottomRight,
            child:  Text('${task.taskDate}'.toString().substring(0,11) + ' -- ' +'${task.taskDate}'.toString().substring(11,16),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(

                    color: Get.theme.listTileTheme.textColor,
                    fontSize: 16
                )
            ),

            ),

          ),

        ),
      );

  }
}
