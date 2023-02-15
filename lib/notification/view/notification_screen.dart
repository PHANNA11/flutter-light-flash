import 'package:first_app/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationController notification;
  initData() async {
    await notification.init().then((value) => debugPrint('Notification Init'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initData();
  }

  // void listenNotifications() =>
  //     NotificationController.onNotification.stream.listen((event)=> onClickNotification('Hello Notificatin'));
  // void onClickNotification(String? playload)=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => ,));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await notification.showNotifacation(
                  1, 'Test Notifi', 'Hello Flutter ');
            },
            child: const Text('Alert show')),
      ),
    );
  }
}
