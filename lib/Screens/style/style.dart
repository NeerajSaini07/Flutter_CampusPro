import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle appBarTitle = TextStyle(
    color: AppColors.whitetextcolor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle cardTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle cardContent = TextStyle(
    fontSize: 16.sp,
    color: AppColors.blacktextcolor,
  );

  static TextStyle cardDate = TextStyle(
      fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.whitetextcolor,
    fontSize: 16.sp,
  );

  static TextStyle filterTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
  );

  static TextStyle filterOptionTextStyle = TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
}
