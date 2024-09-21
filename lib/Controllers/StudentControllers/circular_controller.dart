import 'dart:developer';
import 'dart:io';

import 'package:campuspro/Modal/student_module/student_circular_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_circular_repo.dart';
import 'package:campuspro/Services/notificationService/notification_service.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum CircularStatus { initial, loading, success, error }

class CircularController extends GetxController {
  var toDate = Rx<DateTime?>(null);
  var fromDate = Rx<DateTime?>(null);
  RxString filtererrormsg = "".obs;
  RxInt filterCircular = 1.obs;
  var status = CircularStatus.loading.obs;

  //Searching
  RxString searchQuery = "".obs;
  RxList<StudentCircularModel> originalCircularList =
      <StudentCircularModel>[].obs;
  RxList<StudentCircularModel> filteredCircularList =
      <StudentCircularModel>[].obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filterCircular.value = 1;
    searchQuery.value = "";
    ever(searchQuery, (_) => searchCircularList());
  }

  Future<List<StudentCircularModel>> getStudentCircular() async {
    status.value = CircularStatus.loading;
    try {
      final response = await StudentCircularRepo.getStudentCircular();
      List<dynamic> circularData = response['Data'];
      StudentCircularList.studentCircularList = circularData
          .map((json) => StudentCircularModel.fromJson(json))
          .toList();
      originalCircularList.value = StudentCircularList.studentCircularList;
      toDate.value = null;
      fromDate.value = null;
      status.value = CircularStatus.success;
      return StudentCircularList.studentCircularList;
    } catch (e) {
      status.value = CircularStatus.error;
      return [];
    }
  }

  void searchCircularList() {
    if (searchQuery.isEmpty) {
      filteredCircularList.value = originalCircularList;
    } else {
      try {
        final regex = RegExp(searchQuery.value, caseSensitive: false);
        filteredCircularList.value = originalCircularList
            .where((circular) =>
                regex.hasMatch(circular.cirSubject ?? '') ||
                regex.hasMatch(circular.cirNo ?? ''))
            .toList();
      } catch (e) {
        filteredCircularList.value = [];
      }
    }
  }

  //Select Date
  Future<void> selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: type == "to"
          ? (toDate.value ?? DateTime.now())
          : (fromDate.value ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (type == "to") {
      if (picked != null && picked != toDate.value) {
        if (picked.isAfter(fromDate.value!) ||
            picked.isAtSameMomentAs(fromDate.value!)) {
          toDate.value = picked;
          filtererrormsg.value = '';
        } else {
          filtererrormsg.value =
              'To date should be greater than or equal to from date';
        }
      }
    } else {
      if (picked != null && picked != fromDate.value) {
        fromDate.value = picked;
        filtererrormsg.value = '';
        toDate.value = null;
      }
    }
  }
  //Download File

  Future<void> downloadFile(StudentCircularModel circularItem) async {
    try {
      // Request storage permissions
      bool permission = await requestPermissions();
      String url = circularItem.circularFileurl ?? "";
      String fileName = url.split('/').last;

      if (permission) {
        // Get the document directory path
        final directory = await getDownloadDirectory();
        final filePath = path.join(directory.path, fileName);
        if (await File(filePath).exists()) {
          openFile(filePath);
          circularItem.isDownloaded.value = true;
        } else {
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
              circularItem.isDownloaded.value = true;
              // print('File downloaded: $filePath');
            },
            onError: (error) {
              // print('Error: $error');
            },
            cancelOnError: true,
          );
        }
      } else {
        CommonFunctions.showErrorSnackbar("Permission Denied",
            'Storage permission is required to download files.');

        // openAppSettings();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  //Storage Permission
  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
      return true;
      // if (await Permission.manageExternalStorage.request().isGranted) {
      //   log('MANAGE_EXTERNAL_STORAGE permission granted');
      //   return true;
      // } else {
      //   // log('MANAGE_EXTERNAL_STORAGE permission denied');
      //   return false;
      // }
    } else if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted) {
        log('Photos permission granted');
        if (await Permission.mediaLibrary.request().isGranted) {
          log('Media Library permission granted');
          return true;
        } else {
          log('Media Library permission denied');
          return false;
        }
      } else {
        log('Photos permission denied');
        return false;
      }
    } else {
      return false;
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
