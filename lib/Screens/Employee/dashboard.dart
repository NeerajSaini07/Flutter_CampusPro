// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/student_module/notification_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/common_menu_card.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Wedgets/greeting_message.dart';
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
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primarycolor,
                      Colors.blue[300]!,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                            'Hi ${UserTypeslist.userTypesDetails[userTypeController.usertypeIndex].stuEmpName!.toLowerCase()}',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '${getGreetingMessage()},',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5.h),
                  ]),
                ),
              ),

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
