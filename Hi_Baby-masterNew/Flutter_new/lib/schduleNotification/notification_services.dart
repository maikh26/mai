import 'dart:async';
import 'package:flutter/services.dart';

class ScheduleNotifications {

  static const MethodChannel _channel =  const MethodChannel('schedule_notifications');

  // String text: Text to be showed in notification.
  // DateTime when: When notification should be send.
  // If *repeatAt* is empty, the tool will use this value.
  // List<int> repeatAt: A list of weekdays [1..7]. When 1 is Monday (see DateTime weekday).
  static Future<dynamic> schedule(String text, DateTime when, List<int> repeatAt) {
    return _channel.invokeMethod('scheduleNotification', [text, when.toString(), repeatAt]);
  }

  static Future<dynamic> unschedule() {
    return _channel.invokeMethod('unscheduleNotifications');
  }

  // Android only
  static Future<dynamic> setNotificationIcon(int icon) {
    return _channel.invokeMethod('setNotificationIcon', [icon]);
  }

  // iOS only
  static Future<dynamic> requestAuthorization() {
    return _channel.invokeMethod('requestAuthorization');
  }

}































/*

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

/*class localNotificationManeger {
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  localNotificationManeger.init() {
    if (Platform.isIOS) {
      requestIOSPremission();
    }
    initializePlatform();
  }
  requestIOSPremission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings("mother");
    final initSettingIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
              id: id, title: title, body: body, payload: payload);
          didReceiveLocalNotificationSubject.add(notification);
        });

    initSetting = InitializationSettings(initSettingAndroid, initSettingIOS);
  }

  setONNotificationReceive(Function onNotificationRecevie) {
    didReceiveLocalNotificationSubject.listen((Notification) {
      onNotificationRecevie(Notification);
    });
  }

  setONNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<Void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.Max, priority: Priority.High, playSound: true,
        timeoutAfter:5000,
        enableLights: true
        );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0, 'Test Title', 'Test body', platformChannel,
        payload: 'new Paylpoad');
  }

   Future<Void> scheduleNotification() async {
     //var scheduleNotificationDateTime=DateY
    var androidChannel = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.Max, priority: Priority.High, playSound: true,
        timeoutAfter:5000,
        enableLights: true
        );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0, 'Test Title', 'Test body', platformChannel,
        payload: 'new Paylpoad');
  }
}

localNotificationManeger LocalNotificationManeger =
    localNotificationManeger.init();

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceiveNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}*/
class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimezone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("mother");
    final InitializationSettings initializationSettings =
        InitializationSettings(
            initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }
  scheduledNotification() async {
     await flutterLocalNotificationsPlugin.Schedule(
         0,
         'scheduled title',
         'theme changes 5 seconds ago',
         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
         const NotificationDetails(
              AndroidNotificationDetails('your channel id',
                 'your channel name', 'your channel description')),
                 
       /*  androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime*/);

   }
  /*scheduledNotification(int hour, int minutes) async {
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'scheduled title',
      'theme changes 5 seconds ago',
      _converTime(hour, minutes),
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),

      const NotificationDetails(
          AndroidNotificationDetails('your channel id', 'your channel name',
              'your channel description'),
          IOSNotificationDetails(
            sound: 'your channel id',
          )),
      androidAllowWhileIdle: true,

       uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
    );
  }*/

  tz.TZDateTime _converTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

 Future<void> displayNotification({String title, String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_sound',
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => Container(
          color: Colors.white,
        ));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    
    Get.dialog(Text("welcome"));
  }
}
*/