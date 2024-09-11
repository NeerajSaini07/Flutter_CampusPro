import 'dart:io';

import 'package:campuspro/Modal/student_module/student_circular_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_circular_repo.dart';
import 'package:campuspro/Services/notificationService/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CircularController extends GetxController {
  Future<List<StudentCircularModel>> getStudentCircular() async {
    final response = await StudentCircularRepo.getStudentCircular();
    List<dynamic> circularData = response['Data'];
    StudentCircularList.studentCircularList = circularData
        .map((json) => StudentCircularModel.fromJson(json))
        .toList();
    return StudentCircularList.studentCircularList;
  }

  //Download File

  Future<void> downloadFile(String url, String fileName) async {
    try {
      // Request storage permissions
      await requestPermissions();
      // Get the document directory path
      final directory = await getDownloadDirectory();
      final filePath = path.join(directory.path, fileName);

      // Show a notification when download starts
      await showNotification(
          'Download Started', 'Downloading $fileName', filePath,
          progress: 0);

      // Fetch the file from the network
      final response =
          await http.Client().send(http.Request('GET', Uri.parse(url)));
      final totalBytes = response.contentLength ?? 0;
      int receivedBytes = 0;

      final file = File(filePath);
      final sink = file.openWrite();
      response.stream.listen(
        (List<int> chunk) {
          receivedBytes += chunk.length;
          sink.add(chunk);
          final progress = ((receivedBytes / totalBytes) * 100).toInt();
          showNotification('Downloading...', fileName, filePath,
              progress: progress);
        },
        onDone: () async {
          await sink.close();
          await showNotification('Download Completed', fileName, filePath,
              progress: 100);
          // print('File downloaded: $filePath');
        },
        onError: (error) {
          // print('Error: $error');
        },
        cancelOnError: true,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  //Storage Permission
  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
    } else if (Platform.isIOS) {
      await Permission.photos.request();
    }
  }

  //Download directory Path
  Future<Directory> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  Future<void> showNotification(String title, String body, String filePath,
      {int progress = 0}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('download_channel', 'Downloads',
            channelDescription: 'Download notifications',
            importance: Importance.max,
            priority: Priority.high,
            showProgress: true,
            maxProgress: 100,
            playSound: true,
            progress: progress,
            ongoing: progress < 100);

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
            presentSound: true, presentAlert: true, presentBadge: true);

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: filePath,
    );
  }
}
