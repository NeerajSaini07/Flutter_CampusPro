import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../greeting_message.dart';

Widget userProfileName() {
  final UserTypeController userTypeController = Get.find<UserTypeController>();
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.grediant1,
          AppColors.grediant2,
        ],
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.r),
        bottomRight: Radius.circular(30.r),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      // Add padding for spacing
      child: Stack(children: [
        // Left side: Text
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                UserTypeslist.userTypesDetails[userTypeController.usertypeIndex]
                            .ouserType
                            .toString() ==
                        "G"
                    ? "Safety begins with teamwork."
                    : 'Hi, ${UserTypeslist.userTypesDetails[userTypeController.usertypeIndex].stuEmpName!.capitalizeFirst}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleAndsubtitleColor,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                '${getGreetingMessage()},',
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.titleAndsubtitleColor),
              ),
            ],
          ),
        ),

        // Right side: CircleAvatar
      ]),
    ),
  );
}
