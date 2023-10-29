import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:task_manager/app/admin/screens/all_tasks.dart';
import 'package:task_manager/app/employee/screens/employee_home_screen.dart';

class LocalNotificationService{
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final AndroidInitializationSettings _androidInitializationSettings = AndroidInitializationSettings('@drawable/launch_background') ;
  void x (String? p) async{
   //Get.to(EmployeeHomeScreen());
  }

void initializationNotification() async{
  InitializationSettings initializationSettings = InitializationSettings(
    android: _androidInitializationSettings,
  ) ;
   _flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: x);
}//Get.to(NotifiScreen()
void sendNotification(String titleTask,String bodyeTask) {
  AndroidNotificationDetails _androidNotificationDetails= AndroidNotificationDetails(
    'Task_Manager_Id',
    'Task_Manager_Name',
    channelDescription: 'Task Manager',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,

  );
  NotificationDetails notificationDetails =NotificationDetails(
    android: _androidNotificationDetails,
  );
   _flutterLocalNotificationsPlugin.show(
      3,
      '${titleTask}',
      '${bodyeTask}',
      notificationDetails,
       //payload:'hhhhhhhh'

  );

}

}
