import 'package:antpire/src/pages/sub_pages/notifications/token.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();

    final PushNotificationProvider pushProvider = PushNotificationProvider();
    pushProvider.initNotifications();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('Open!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   print('Got a message whilst in the Background!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Hola')],
    );
  }
}
