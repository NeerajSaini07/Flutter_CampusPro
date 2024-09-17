import 'dart:developer';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher_string.dart';

@pragma('vm:entry-point')
Future<void> onDidReceiveNotificationResponse(
    NotificationResponse response) async {
  // Handle notification tap
  final payload = response.payload;
  if (payload != null) {
    await openFile(payload).then((value) {
      Get.offAllNamed(Routes.userType);
    });
  }
}

@pragma('vm:entry-point')
Future<void> onDidReceiveBackgroundNotificationResponse(
    NotificationResponse response) async {
  // Handle background notification tap
  final payload = response.payload;
  if (payload != null) {
    await openFile(payload).then((value) {
      Get.offAllNamed(Routes.userType);
    });
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id of the channel
  'High Importance Notifications', // channel name
  description:
      'This channel is used for important notifications.', // channel description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handling background messages and showing notifications
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
          iOS: const DarwinNotificationDetails(
              presentSound: true, presentAlert: true, presentBadge: true),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: "@drawable/file",
            importance: Importance.max,
            priority: Priority.max,
            visibility: NotificationVisibility.public,
            largeIcon:
                const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
            // Provides expanded notification to show all body text
            styleInformation: const BigTextStyleInformation(''),
          ),
        ));
  }
}

class NotificationService {
  Future initialize() async {
    await Firebase.initializeApp();
    // Setting up background message handler and creating notification channel
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
  }
}

void prompt(String url) async {
  // Launching URL if it's valid, otherwise throwing an error
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}

initializeNotification() async {
  // Initializing Android notification settings
  const initialzationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS notification settings with sound, alert, and badge permissions
  const DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings(
    requestSoundPermission: true, // Request sound permission explicitly
    requestBadgePermission: true, // Request badge permission explicitly
    requestAlertPermission: true, // Request alert permission explicitly
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  // Combining both Android and iOS settings
  const initializationSettings = InitializationSettings(
    android: initialzationSettingsAndroid,
    iOS: iosInitializationSettings,
  );

  // Listening to foreground messages (when app is open) and showing notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            iOS: const DarwinNotificationDetails(
                presentSound: true, presentAlert: true, presentBadge: true),
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: "@drawable/file",
              importance: Importance.max,
              priority: Priority.max,
              visibility: NotificationVisibility.public,
              largeIcon:
                  const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
              // Provides expanded notification to show all body text
              styleInformation: const BigTextStyleInformation(''),
            ),
          ));
    }
  });

  // Initializing the Flutter local notifications plugin
  // Initialize the notification plugin
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
  );

  // Requesting permission to show notifications and getting the FCM token
  await requestNotificationPermission();
  getToken();
}

Future requestNotificationPermission() async {
  // Request notification permissions on iOS
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User granted provisional permission');
  } else {
    log('User declined or has not accepted permission');
  }
}

Future selectNotification(String? payload) async {
  // Handling notification tap (if any action needs to be taken on tap)
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

Future onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {}

Future<void> getToken() async {
  // Fetching and logging the FCM token
  final token = await FirebaseMessaging.instance.getToken();
  log("FCM Token generated => $token");
  await Sharedprefdata.storeStringData(
      Sharedprefdata.fcmToken, token.toString());
}

Future instantNotification() async {
  // Creating and showing an instant notification (manually triggered)
  var android = const AndroidNotificationDetails(
    "id",
    "channel",
    icon: "@mipmap/ic_launcher",
    largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
    styleInformation: BigTextStyleInformation(''),
  );

  var ios = const DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);

  var platform = NotificationDetails(android: android, iOS: ios);

  // Showing the notification
  await flutterLocalNotificationsPlugin.show(
      0, "Instant notification", "Tap to do something", platform,
      payload: "Welcome to app");
}

Future<void> openFile(String filePath) async {
  final result = await OpenFile.open(filePath);
  print(result.message);
}
