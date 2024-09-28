// ignore_for_file: deprecated_member_use

import 'package:campuspro/Controllers/feedback_controller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/feedback/feedbackcard.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentFeedbackController feedbackController =
        Get.find<StudentFeedbackController>();
    return Scaffold(
      backgroundColor: AppColors.titleAndsubtitleColor,
      appBar: customAppBar(context, title: "Feedback"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: Column(
            children: [
              Expanded(
                child: feedbackdetailCard(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          feedbackController.clearFeedbackFields();
          Get.to(() => const Feedbackcard());
        },
        backgroundColor: AppColors.appbuttonColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 36.w,
        ),
      ),
    );
  }
}
