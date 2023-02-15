import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationController {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelid', 'channelname',
          channelDescription: 'channeldescription',
          importance: Importance.max,
          playSound: true,
          actions: []),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future init({bool initSchedule = false}) async {
    print('test init function');
    const android = AndroidInitializationSettings('');
    const ios = DarwinInitializationSettings(requestAlertPermission: true);
    const setting = InitializationSettings(
      android: android,
      iOS: ios,
    );
    await _notifications.initialize(
      setting,
      onDidReceiveNotificationResponse: (details) async {
        onNotification.add(details.payload);
      },
    );
  }

  Future<void> showNotifacation(int id, String title, String body) async {
    final detail = await _notificationDetails();
    await _notifications.show(id, title, body, detail);
  }
}
