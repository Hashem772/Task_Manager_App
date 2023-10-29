import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
class NotificationService{
  final String serverToken = "AAAAklsCwhQ:APA91bHtsg24aDu5qMKVJC9nei47TDs3ZYZHpUK-mML6xRL32jTD0h1fThmpfBkKbqNNu8W26NxIUi1ggShtQYFdq2kXGsG7JxWMzY4ycrSkf1D0o7vd3Ikggr6NzzexgrVH1_hr_5Xj";
  final FirebaseMessaging firebaseMessaging =FirebaseMessaging.instance;

  Future<void> sendPushMessage(String userToken,String title, String bodyOfMassege) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
//        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',// charset=UTF-8
          'Authorization': 'key=$serverToken',
        },
        body:
        jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': '${title}',
              'body': '${bodyOfMassege}',

            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            //'to': _userData[0].user_token,
            //'to':'eDyXHTs8SlOMyQom-5-cQz:APA91bGsJBObTC1NJFgifGCe9usrg7nx-vsfYwxRTkHNfWkkz-5xuuAORd8QAzxpUNrPYRRprfbpHLcM1J8x_hn1VvwHdLL3klYtzXdThFgO-BF8XQ7jU9L3icSophQntAeoVDprcFFh',
            'to':userToken,
          },
        ),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }


  getMessage(){
    FirebaseMessaging.onMessage.listen((message) {
      print("-----------------------------------------------------");
      print(message.notification!.title);
      print(message.notification!.body);
    });
  }
}