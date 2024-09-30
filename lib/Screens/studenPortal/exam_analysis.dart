import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/bar_chart.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/filter_diloag.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/StudentWidget/examAnalysis/line_chart_graph.dart';

class StudentExamAnalysisScreen extends StatefulWidget {
  const StudentExamAnalysisScreen({super.key});

  @override
  State<StudentExamAnalysisScreen> createState() =>
      _StudentExamAnalysisScreenState();
}

class _StudentExamAnalysisScreenState extends State<StudentExamAnalysisScreen> {
  final ExameAnalysisController exameAnalysisController = Get.find();
  @override
  void initState() {
    super.initState();
    exameAnalysisController.getExamData();
    exameAnalysisController.getclasssession();
    exameAnalysisController.analysisdata();
  }

  @override
  Widget build(BuildContext context) {
    final ExameAnalysisController exameAnalysisController =
        Get.find<ExameAnalysisController>();
    final ExamTestExamResultController examResultController =
        Get.find<ExamTestExamResultController>();

    return Scaffold(
      appBar: customAppBar(context, title: "Exam Analysis"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Spacer(),
                  // exameAnalysisController.singleExamDataList.isNotEmpty
                  //     ? Obx(
                  //         () => Expanded(
                  //           child: Text(
                  //             exameAnalysisController
                  //                 .singleExamDataList.last.exam,
                  //             textAlign: TextAlign.start,
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 14.sp,
                  //                 color: AppColors.blacktextcolor),
                  //           ),
                  //         ),
                  //       )
                  //     : const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      exameAnalysisController.startfilter.value = true;
                      examResultController.bottomshitopenforExamResult.value =
                          false;
                      modalBottomSheetMenu(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            Constant.filtericon,
                            height: 20.h,
                            width: 20.w,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              CustomeHeight(10.h),
              Obx(() {
                if (exameAnalysisController.showloader.value) {
                  return const CircularProgressIndicator();
                } else {
                  if (exameAnalysisController.showSingleExamGhraph.value) {
                    if (exameAnalysisController.singleExamDataList.isNotEmpty) {
                      return barchartForSingleExam(context);
                    } else {
                      return Center(
                        child: Text(
                          "No data available",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  } else {
                    if (exameAnalysisController.studentReport.isNotEmpty) {
                      return lineCartGraphWidget(context);
                    } else {
                      return Center(
                        child: Text(
                          "No data available",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
