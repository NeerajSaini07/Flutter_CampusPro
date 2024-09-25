import 'dart:math';

import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
        return "assets/icon/notification.png";
      case "notification":
        return "assets/icon/notification.png";
      case "leave detail":
        return "assets/icon/leave.png";
      case "leave request":
        return "assets/icon/leave.png";
      case "fee payment":
        return "assets/icon/fees.png";
      case "classroom":
        return "assets/icon/classroom.png";
      case "class room":
        return "assets/icon/classroom.png";
      case "home work":
        return "assets/icon/homework.png";
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
        return "assets/icon/students.png";
      case "student":
        return "assets/icon/students.png";
      case "item requirment":
        return "assets/icon/Item Requirement.png";
      case "attendance":
        return "assets/icon/attendance.png";
      case "exam mark entry":
        return "assets/icon/Test Marks Entry.png";
      case "calendar":
        return "assets/icon/Calendar.png";
      case "calender":
        return "assets/icon/Calendar.png";
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
}
