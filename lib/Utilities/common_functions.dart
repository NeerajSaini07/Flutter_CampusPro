// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

class CommonFunctions {
  // Function to show error
  static void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.warningColor,
    );
  }

  // Function to show success
  static void showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successColor,
    );
  }

  // Function to make a phone call
  static Future<void> makePhoneCall(String number) async {
    final RegExp phoneRegex = RegExp(r'^\d{10}$');
    if (phoneRegex.hasMatch(number)) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: number,
      );
      await launchUrl(launchUri);
    } else {
      showErrorSnackbar("Invalid Phone Number",
          "Ensure your phone number is 10 digits long.");
    }
  }

  //Calculating Days between the 2 dates
  static int calculateDaysBetween(
      {required String startDateStr, required String endDateStr}) {
    final DateFormat dateFormat = DateFormat('dd MMM yyyy');

    DateTime startDate = dateFormat.parse(startDateStr);
    DateTime endDate = dateFormat.parse(endDateStr);

    if (startDate.isAfter(endDate)) {
      DateTime temp = startDate;
      startDate = endDate;
      endDate = temp;
    }

    return endDate.difference(startDate).inDays;
  }

  //Fetch Dashboard Icons
  static String fetchDahboardIcon({required String menuname}) {
    switch (menuname.toLowerCase()) {
      case "alert & notification":
      case "notification":
        return "assets/icon/notification.png";
      case "leave detail":
      case "leave request":
        return "assets/icon/leave.png";
      case "fee payment":
        return "assets/icon/fees.png";
      case "classroom":
      case "class room":
        return "assets/icon/classroom.png";
      case "home work":
      case "homework":
        return "assets/icon/homework.png";
      case "online test":
        return "assets/dashboard_icon/online-test status.png";
      case "exam/test result":
        return "assets/icon/results.png";
      case "activity":
        return "assets/icon/activity.png";
      case "exam":
        return "assets/icon/exam.png";
      case "student list":
        return "assets/icon/student.png";
      case "student":
        return "assets/icon/student.png";
      case "item requirment":
        return "assets/dashboard_icon/Item Requirement.png";
      case "attendance":
        return "assets/icon/attendance.png";
      case "exam mark entry":
        return "assets/dashboard_icon/Test Marks Entry.png";
      case "calendar":
      case "calender":
        return "assets/dashboard_icon/calendar.png";
      default:
        return "assets/dashboard_icon/$menuname.png";
    }
  }

  static List formatDateString(String input) {
    List<String> parts = input.split(' to ');
    if (parts.length == 2) {
      DateTime startDate =
          DateFormat('dd-MMM-yyyy').parse(parts[0].toString().trim());
      DateTime endDate =
          DateFormat('dd-MMM-yyyy').parse(parts[1].toString().trim());
      return [
        "${startDate.day}-${endDate.day} ${DateFormat.MMM().format(endDate)}",
        "${endDate.year}",
        "${DateFormat('EEE').format(startDate)}-${DateFormat('EEE').format(endDate)}"
      ];
    } else {
      DateTime date =
          DateFormat('dd-MMM-yyyy').parse(parts[0].toString().trim());
      return [
        "${date.day} ${DateFormat.MMM().format(date)}",
        "${date.year}",
        DateFormat('EEEE').format(date)
      ];
    }
  }

  static getfiles() async {
    final StudentClasssRoomController classsRoomController =
        Get.find<StudentClasssRoomController>();

    final StudentHomeWorkController studentHomeWorkController =
        Get.find<StudentHomeWorkController>();

    if (Platform.isAndroid) {
      bool permissionStatus = await requestPermission();

      if (!permissionStatus) {
        Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.selfcolor,
          "File",
          "Please Allow File Permission",
        );
        return;
      }
    }

    XTypeGroup typeGroup;
    if (Platform.isIOS) {
      typeGroup = XTypeGroup(
        label: 'documents',
        uniformTypeIdentifiers: const [
          'com.adobe.pdf',
          'public.jpeg',
          'public.jpg'
        ],
      );
    } else {
      typeGroup = XTypeGroup(
        label: 'documents',
        extensions: const ['pdf', 'jpg', 'jpeg'],
      );
    }

    final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

    if (file != null) {
      String filePath = file.path;
      final File selectedFile = File(filePath);
      int fileSizeInBytes = await selectedFile.length();
      double fileSizeInKB = fileSizeInBytes / 1024;
      double filesize = fileSizeInKB / 1024;

      if (filesize < 4) {
        if (classsRoomController.filepicforClassRoom.value) {
          classsRoomController.filesource.value = filePath;
          classsRoomController.fileName.value = path.basename(filePath);
        } else {
          studentHomeWorkController.commentfile.value = filePath;
          studentHomeWorkController.filename.value = path.basename(filePath);
        }
      } else {
        Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.selfcolor,
          "File",
          "File size Too Large, upload within 4 MB",
        );
      }
    } else {
      Get.snackbar(
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.selfcolor,
        "File",
        "Please Select File",
      );
    }
  }

  static BoxShadow commonsadhow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      blurRadius: 2,
      offset: const Offset(0.5, 0.5),
    );
  }

  static Future<bool> requestPermission() async {
    PermissionStatus permissionStatus1 =
        await Permission.manageExternalStorage.request();
    PermissionStatus permissionStatus2 = await Permission.storage.request();
    return (permissionStatus1.isGranted || permissionStatus2.isGranted);
  }
}
