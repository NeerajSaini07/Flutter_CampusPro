// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/common_menu_card.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/common_userProfile_ondashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Wedgets/recent_notification.dart';

class EmployeeDashboard extends StatelessWidget {
  EmployeeDashboard({super.key});

  final AppbarController appbarController = Get.find<AppbarController>();

  final UserTypeController userTypeController = Get.find<UserTypeController>();

  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
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
              //  ******************  user profile *****************

              userProfileName(),

              // ******************************
              SizedBox(height: 5.h),
              // MarqueeWidget(),
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
