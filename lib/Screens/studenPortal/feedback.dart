// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/feedback/feedbackcard.dart';

import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppbarController appbarController = Get.find<AppbarController>();
    BottomBarController bottomBarController = Get.find<BottomBarController>();

    return WillPopScope(
        onWillPop: () async {
          bottomBarController.selectedBottomNavIndex.value = 0;
          appbarController.appBarName.value = Constant.schoolName;
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.titleAndsubtitleColor,
          appBar: customAppBar(context),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                feedbackCard(context),
                //: SizedBox(),
                CustomeHeight(18.h),
                Expanded(child: feedbackdetailCard()),
              ],
            ),
          ),
        ));
  }
}

// Widget for Day Text to avoid repetition
