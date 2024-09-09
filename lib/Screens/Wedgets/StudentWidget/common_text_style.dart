// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Define a class for text styles
class AppTextStyles {
  static TextStyle appBarTitle = TextStyle(
    color: AppColors.whitetextcolor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle cardTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle cardContent = TextStyle(
    fontSize: 16.sp,
    color: AppColors.blacktextcolor,
  );

  static TextStyle cardDate = TextStyle(
    fontSize: 14.sp,
    color: Colors.black,
  );

  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.whitetextcolor,
    fontSize: 16.sp,
  );

  static TextStyle filterTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
  );

  static TextStyle filterOptionTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
}
