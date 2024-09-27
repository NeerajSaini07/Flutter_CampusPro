import 'dart:io';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:campuspro/Services/notificationService/notification_service.dart';

class DownloadService extends GetxService {
  //Download File
  Future<void> downloadFile(String url) async {
    // ***********Request storage permissions
    bool permission = true;
    if (Platform.isAndroid) {
      permission = await requestPermissions();
    }
    String fileName = url.split('/').last;
    try {
      if (permission) {
        // **********Get the document directory path
        final directory = await getDownloadDirectory();
        final filePath = path.join(directory.path, fileName);
        // if (await File(filePath).exists()) {
        //   openFile(filePath);
        //   downloadedStatus.value = true;
        // } else {
        // **********Show a notification when download starts
        await showNotification(
            'Download Started', 'Downloading $fileName', filePath,
            progress: 0, playSound: true);

        // **********Fetch the file from the network
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
                progress: progress, playSound: false);
          },
          onDone: () async {
            await sink.close();
            await showNotification('Download Completed', fileName, filePath,
                progress: 100, playSound: true);
            Future.delayed(const Duration(milliseconds: 500), () {
              openFile(filePath);
            });
            // downloadedStatus.value = true;
            // print('File downloaded: $filePath');
          },
          onError: (error) {
            // print('Error: $error');
          },
          cancelOnError: true,
        );
        // }
      } else {
        CommonFunctions.showErrorSnackbar("Permission Denied",
            'Storage permission is required to download files.');

        // openAppSettings();
      }
    } catch (e) {
      print('Error: $e');
    }
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

//Storage Permission
Future<bool> requestPermissions() async {
  if (Platform.isAndroid) {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    return true;
  } else if (Platform.isIOS) {
    PermissionStatus photoPermissionStatus =
        await Permission.photosAddOnly.request();
    PermissionStatus docPermissionStatus =
        await Permission.mediaLibrary.request();
    return photoPermissionStatus.isGranted && docPermissionStatus.isGranted;
  } else {
    return false;
  }
}

// **********Show Notification downloading
Future<void> showNotification(String title, String body, String filePath,
    {int progress = 0, required bool playSound}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('download_channel', 'Downloads',
          channelDescription: 'Download notifications',
          importance: Importance.max,
          priority: Priority.high,
          showProgress: true,
          maxProgress: 100,
          playSound: playSound,
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
