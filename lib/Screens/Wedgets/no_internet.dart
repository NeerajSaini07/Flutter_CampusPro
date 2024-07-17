// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("No Internet Connection"),
        content: Text("Please check your internet settings and try again."),
        actions: <Widget>[
          TextButton(
            child: Text(
              "OK",
              style: TextStyle(
                  color: AppColors.appbuttonColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
