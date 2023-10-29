import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager/app/admin/screens/admin_home_screen.dart';
import 'package:task_manager/app/auth/controller/auth_controller.dart';
import 'package:task_manager/app/config/themes/app_theme.dart';
import 'package:task_manager/app/config/themes/my_theme.dart';
import 'package:task_manager/app/employee/screens/employee_home_screen.dart';
import 'package:task_manager/app/model/user_model.dart';
import 'package:task_manager/app/services/local_not.dart';
import 'package:task_manager/app/services/notification_service.dart';
import 'app/auth/screens/login_screen.dart';
import 'package:get/get.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
LocalNotificationService localNotificationService = LocalNotificationService();

Future<void> getMessage(RemoteMessage message) async{
  localNotificationService.sendNotification(message.notification!.title!,message.notification!.body!);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //////////////////////////
  FirebaseMessaging.onBackgroundMessage(getMessage);
  NotificationService().getMessage();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  ///////////////////////// local Notification
  localNotificationService.initializationNotification();
  FirebaseMessaging.onMessage.listen((message) {

    localNotificationService.sendNotification(message.notification!.title!,message.notification!.body!);
  });
  ////////////////////////////////////////////////

  final AuthController authController =
  Get.put(AuthController(), permanent: true);
  final isLogin = await authController.checkUser();
  runApp(MyApp(isLogin: isLogin, ));
  configLoading();
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  MyApp({this.isLogin=false,});
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
//      locale: Locale("ar"),
      title: 'Tasks Managers',
     // theme: MyTheme().lightTheme,
      theme: AppThemes().lightTheme,
      darkTheme:  AppThemes().darkTheme,
      themeMode: ThemeMode.system,
      home: isLogin == false?LoginScreen(): authController.user!.userType == UserType.ADMIN?AdminHomeScreen():EmployeeHomeScreen(),
        builder: EasyLoading.init(),
    );
  }
}

























void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    //..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blueGrey.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}


/*
* FirebaseMessaging.onMessage.listen((message) {
    print("-----------------------------------------------------");
    print(message.notification!.title.toString() +' lllllocaaaaaaaal');
    print(message.notification!.body);
    localNotificationService.sendNotification(message.notification!.body!);
  });*/