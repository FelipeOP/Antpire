import 'package:antpire/src/pages/sub_pages/notifications/show_notification.dart';
import 'package:flutter/material.dart';
import 'notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();

    Notifications.init();
    listenNotifications();
  }

  void listenNotifications() =>
      Notifications.onNotifications.stream.listen(onClickedNotification);
  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ShowNotification(payload: payload),
      ));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
