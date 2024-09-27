import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Modal/student_module/exam_analysis_session_model.dart';
import 'package:campuspro/Modal/student_module/exam_test_result_model.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//  ***************** this modal bottom sheet will work for exam analysis and test exam result opage ***************

modalBottomSheetMenuFroTestResult(BuildContext context) {
  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();

  final ExamTestExamResultController examResultController =
      Get.find<ExamTestExamResultController>();

  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 200.h,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeHeight(16.h),
              Text(
                "Filter by Session & Exam",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headingcolor),
              ),
              CustomeHeight(16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                          hintText: "Select Session",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      items: exameAnalysisController.sessionList
                          .map((SessionModel classsession) {
                        return DropdownMenuItem<SessionModel>(
                            value: classsession,
                            child: Text(classsession.sessionFrom));
                      }).toList(),
                      onChanged: (SessionModel? sessionModel) async {
                        if (sessionModel != null) {
                          exameAnalysisController.session.value =
                              sessionModel.id.toString();
                          await examResultController
                              .studentexamNameForTestResult();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Add spacing between the dropdowns
                  Expanded(
                    child: Obx(
                      () => DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 10.h,
                                bottom: 10.h,
                                left: 10.w,
                                right: 10.w),
                            hintText: "Select Exam Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r))),
                        items: examResultController.examnameListForResult
                            .map((ExamModelForStudentResult examname) {
                          return DropdownMenuItem<ExamModelForStudentResult>(
                              value: examname, child: Text(examname.exam));
                        }).toList(),
                        onChanged: (ExamModelForStudentResult? examnameModel) {
                          if (examnameModel != null) {
                            examResultController.examname.value =
                                examnameModel.examId.toString();
                            // exam.examName.value =
                            //     examnameModel.examId.toString();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              CustomeHeight(16.h),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.appbuttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: (exameAnalysisController.session.value.isEmpty ||
                            exameAnalysisController.examName.value.isEmpty)
                        ? null
                        : () {
                            if (examResultController
                                .bottomshitopenforExamResult.value) {
                              examResultController.testExamResult();
                            } else {
                              exameAnalysisController
                                  .filterExamDataBySessionAndExam();
                            }
                          },
                    child: Text(
                      "Apply Filter",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whitetextcolor,
                      ),
                    ),
                  ),
                ),
                Obx(() => exameAnalysisController.removefilter.value
                    ? SizedBox(
                        width: 10.w,
                      )
                    : SizedBox()),
                Obx(() => exameAnalysisController.removefilter.value
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.appbuttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r))),
                        onPressed: () {
                          exameAnalysisController.showSingleExamGhraph.value =
                              false;
                          exameAnalysisController.removefilter.value = false;
                          exameAnalysisController.analysisdata();
                          Get.back();
                        },
                        child: Text("Remove Filter",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whitetextcolor)))
                    : SizedBox())
              ])
            ],
          ),
        );
      }).whenComplete(() {
    if (exameAnalysisController.removefilter.value == false) {
      exameAnalysisController.examName.value = '';
      exameAnalysisController.session.value = '';
    }
  });
}

// exameAnalysisController
//                               .filterExamDataBySessionAndExam