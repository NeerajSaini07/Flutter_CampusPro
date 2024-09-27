// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/ExamTestResult/filter_dialog_for_examResult.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/ExamTestResult/result_graph.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Wedgets/StudentWidget/ExamTestResult/subject_marks.dart';

class StudentExamTestResultScreen extends StatelessWidget {
  const StudentExamTestResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExamTestExamResultController examResultController =
        Get.find<ExamTestExamResultController>();
    return Scaffold(
      appBar: customAppBar(context, title: "Exam/Test Result"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      examResultController.bottomshitopenforExamResult.value =
                          true;
                      modalBottomSheetMenuFroTestResult(context);
                    },
                    child: Image.asset(
                      Constant.filtericon,
                      height: 20.h,
                      width: 20.w,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              CustomeHeight(16.h),
              Obx(() {
                if (examResultController.showloader.value) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (examResultController.testMarksResultList.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Available",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blacktextcolor,
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      studentMarksdetails(),
                      CustomeHeight(16.h),
                      SizedBox(
                        height: 300.h,
                        child: resultGraph(context),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
