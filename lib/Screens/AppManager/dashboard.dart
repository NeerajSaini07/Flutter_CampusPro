// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/common_menu_card.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/common_userProfile_ondashboard.dart';
import 'package:campuspro/Screens/Wedgets/recent_notification.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppManagerDashboard extends StatelessWidget {
  const AppManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.find<NotificationController>();
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/userTypeBackGround.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 1.0,
          ),
          child: Column(
            children: [
              userProfileName(),
              SizedBox(height: 5.h),
              Obx(
                () => notificationController.notificationStatus.value
                    ? SimpleSliderWidget()
                    : SizedBox(),
              ),
              SizedBox(height: 7.h),
              Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: buildActionsCard()),
            ],
          ),
        ),
      ),
    );
  }
}
