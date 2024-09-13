// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/common_menu_card.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/common_userProfile_ondashboard.dart';
import 'package:campuspro/Screens/Wedgets/DashboardMenu/recent_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserDashboard extends StatelessWidget {
  UserDashboard({super.key});

  final AppbarController appbarController = Get.find<AppbarController>();
  final UserTypeController userTypeController = Get.find<UserTypeController>();
  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //  ******************  user profile *****************
          userProfileName(),
          // ******************************
          SizedBox(height: 20.h),
          Obx(
            () => notificationController.dashboardnotification.isNotEmpty
                ? recentnotificationOnDashboard(context)
                : SizedBox(),
          ),
          SizedBox(height: 10.h),
          SizedBox(height: 7.h),
          buildActionsCard(),
        ],
      ),
    );
  }
}
