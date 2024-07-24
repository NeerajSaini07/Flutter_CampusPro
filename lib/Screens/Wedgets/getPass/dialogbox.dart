// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future showGetpassDilaog(BuildContext context) {
  final GetPassController getPassController = Get.find<GetPassController>();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.green,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                  textStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                child: Text(
                  "Today's GatesPass History",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  // style: TextStyle(
                  //     fontSize: 12.sp,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  getPassController.showvisitorDetails.value = false;
                  await Future.delayed(Duration(microseconds: 10));
                  getPassController.showvisitoryHistory.value = true;
                  getPassController.showOTPwidget.value = false;
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 16.h,
                  ),
                  textStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                child: Text(
                  "Today's Visitor History",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
