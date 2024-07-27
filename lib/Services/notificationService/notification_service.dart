import 'dart:developer';

import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NotificationService {
  Future initialize() async {
    //await Firebase.initializeApp();
    // FirebaseMessaging.instance.requestPermission(
    //     alert: true, badge: true, carPlay: true, sound: true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
  }
}

void prompt(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.data}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    log("Notification Title : ${notification.title}");
    log("Notification Body : ${notification.body}");
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          iOS: DarwinNotificationDetails(
              presentSound: true, presentAlert: true, presentBadge: true),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: "@drawable/file",
            importance: Importance.max,
            priority: Priority.max,
            visibility: NotificationVisibility.public,
            largeIcon:
                DrawableResourceAndroidBitmap("@drawable/ic_notification"),

            // User For Providing expanded button in notification such that to show all body text
            styleInformation: BigTextStyleInformation(''),
          ),
        ));
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);
// final IOSFlutterLocalNotificationsPlugin iosChannel=IOSFlutterLocalNotificationsPlugin();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

initializeNotification() async {
  final initialzationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  //******IOs notification settings */
  final DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  final initializationSettings = InitializationSettings(
    android: initialzationSettingsAndroid,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      log("Notification Title : ${notification.title}");
      log("Notification Body : ${notification.body}");
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            iOS: DarwinNotificationDetails(
                presentSound: true, presentAlert: true, presentBadge: true),
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: "@drawable/file",
              importance: Importance.max,
              priority: Priority.max,
              visibility: NotificationVisibility.public,
              largeIcon:
                  DrawableResourceAndroidBitmap("@drawable/ic_notification"),

              // User For Providing expanded button in notification such that to show all body text
              styleInformation: BigTextStyleInformation(''),
            ),
          ));
    }
  });
  getToken();
}

Future selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

Future onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     title: Text(title),
  //     content: Text(body),
  //     actions: [
  //       CupertinoDialogAction(
  //         isDefaultAction: true,
  //         child: Text('Ok'),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SecondScreen(payload),
  //             ),
  //           );
  //         },
  //       )
  //     ],
  //   ),
  // );
}

Future<void> getToken() async {
  final token = await FirebaseMessaging.instance.getToken();
  log("FCM Token generated => $token");
  await Sharedprefdata.storeStringData(
      Sharedprefdata.fcmToken, token.toString());
}

Future instantNofitication() async {
  var android = AndroidNotificationDetails(
    "id",
    "channel",
    icon: "@mipmap/ic_launcher",
    largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),

    // User For Providing expanded button in notification such that to show all body text
    styleInformation: BigTextStyleInformation(''),
  );

  var ios = DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);

  var platform = new NotificationDetails(android: android, iOS: ios);

  await flutterLocalNotificationsPlugin.show(
      0, "Instant notification", "Tap to do something", platform,
      payload: "Welcome to app");
}
