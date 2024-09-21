import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget subjectname() {
  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();
  return Center(
    child: Column(
      children: [
        Text(
          "All exam Analysis Graph",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.headingcolor),
        ),
        CustomeHeight(16.h),
        SizedBox(
          height: 60.h,
          child: Wrap(
              children: List.generate(
                  exameAnalysisController.subjectlist.length, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 5.r,
                    backgroundColor:
                        exameAnalysisController.colorPalette[index],
                  ),
                  Text(exameAnalysisController.subjectlist[index],
                      style: TextStyle(
                          fontSize: 11.sp, color: AppColors.appbuttonColor)),
                ],
              ),
            );
          })),
        ),
      ],
    ),
  );
}
