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
                          examResultController.examid.value = '';
                          examResultController.examnameListForResult.clear();
                          exameAnalysisController.session.value =
                              sessionModel.id.toString();
                          examResultController.filterloader.value = true;
                          print(
                              "session : ${exameAnalysisController.session.value}");
                          await examResultController
                              .studentexamNameForTestResult();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                      () => DropdownButtonFormField(
                        value: examResultController.examid.value.isEmpty
                            ? null
                            : examResultController.examnameListForResult
                                .firstWhere(
                                (exam) =>
                                    exam.examId.toString() ==
                                    examResultController.examid.value,
                              ),
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
                            examResultController.examid.value =
                                examnameModel.examId.toString();

                            print(
                                "examid : ${examResultController.examid.value}");
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
                    onPressed:
                        (exameAnalysisController.session.value.isNotEmpty &&
                                examResultController.examid.value.isNotEmpty)
                            ? examResultController.testExamResult
                            : null,
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