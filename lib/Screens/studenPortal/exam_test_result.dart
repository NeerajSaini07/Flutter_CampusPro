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

class StudentExamTestResultScreen extends StatefulWidget {
  const StudentExamTestResultScreen({super.key});

  @override
  State<StudentExamTestResultScreen> createState() =>
      _StudentExamTestResultScreenState();
}

class _StudentExamTestResultScreenState
    extends State<StudentExamTestResultScreen> {
  final ExamTestExamResultController examResultController =
      Get.find<ExamTestExamResultController>();
  @override
  void initState() {
    super.initState();
    examResultController.studentexamNameForTestResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Exam/Test Result"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Obx(
          () => examResultController.showloader.value
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => examResultController
                                      .testMarksResultList.isNotEmpty
                                  ? Text(
                                      "Exam Name : ${examResultController.examname}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: AppColors.headingcolor,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              examResultController
                                  .bottomshitopenforExamResult.value = true;
                              modalBottomSheetMenuFroTestResult(context);
                            },
                            child: Image.asset(
                              Constant.filtericon,
                              height: 20.h,
                              width: 20.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      CustomeHeight(16.h),
                      Obx(() {
                        if (examResultController.testMarksResultList.isEmpty) {
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
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                studentMarksdetails(),
                                CustomeHeight(16.h),
                                SizedBox(
                                  height: 300.h,
                                  child: resultGraph(context),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
