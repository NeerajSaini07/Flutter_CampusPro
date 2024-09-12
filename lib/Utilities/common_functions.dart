import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
}
