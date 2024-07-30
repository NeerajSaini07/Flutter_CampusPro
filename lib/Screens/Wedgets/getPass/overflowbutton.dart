// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Screens/Wedgets/custom_width.dart';
import 'package:campuspro/Screens/Wedgets/getPass/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget overflowbutton(BuildContext context) {
  return Positioned(
    top: 1.0,
    right: 1.0,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 13.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: Colors.red,
      ),
      onPressed: () {
        showGetpassDilaog(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icon/left-arrow.png',
            width: 24.w,
            height: 26.h,
            color: Colors.red,
            colorBlendMode: BlendMode.screen,
          ),
          customWidth(8.w),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ' SHOW ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    letterSpacing: 2.8,
                  ),
                ),
                TextSpan(
                  text: '  \nHISTORY',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
