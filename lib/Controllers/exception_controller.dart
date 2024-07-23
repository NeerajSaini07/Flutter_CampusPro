import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExceptionController extends GetxController {
  void showDialog({
    required String title,
    required String message,
  }) {
    Get.dialog(
      CustomDialog(
          icon: Icons.warning_amber_rounded,
          title: title,
          message: message,
          btnText: "Try Again!"),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String btnText;
  const CustomDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 60,
            color: Colors.red,
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 18.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(btnText),
        ),
      ],
    );
  }
}
