import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class NotiManager extends GetxService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final initSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  final initSettingsIOS = const IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  AndroidNotificationDetails androidPlatformChannelSpecifics = 
      const AndroidNotificationDetails(
        "a",   //Required for Android 8.0 or after
        "b", //Required for Android 8.0 or after
        channelDescription: "c", //Required for Android 8.0 or after
        importance: Importance.high,
        priority: Priority.high
      );
  
  NotificationDetails? platformChannelSpecifics;

  void initState() {
    _initNotiSetting();
  }

  void _initNotiSetting() async {
  final initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );

  platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}
}