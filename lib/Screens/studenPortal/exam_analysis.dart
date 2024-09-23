// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
// import 'package:campuspro/Modal/student_module/exam_analysis_session_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/bar_chart.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/bottom_list.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/filter_diloag.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/chart_scrore_data_color_widget.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/subject.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/StudentWidget/examAnalysis/line_chart_graph.dart';

class ExameAnalysis extends StatelessWidget {
  const ExameAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final ExameAnalysisController exameAnalysisController =
        Get.find<ExameAnalysisController>();

    final ExamTestExamResultController examResultController =
        Get.find<ExamTestExamResultController>();

    print(
        "student reposrt  in page :  ${exameAnalysisController.studentReport}");

    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
                child: GestureDetector(
                  onTap: () {
                    exameAnalysisController.startfilter.value = true;
                    examResultController.bottomshitopenforExamResult.value =
                        false;
                    modalBottomSheetMenu(context);
                  },
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
              CustomeHeight(10.h),

              Obx(() {
                if (exameAnalysisController.showloader.value) {
                  return CircularProgressIndicator();
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

              // Obx(
              //   () => exameAnalysisController.showSingleExamGhraph.value
              //       ? exameAnalysisController.showloader.value
              //           ? Center(
              //               child: CircularProgressIndicator(),
              //             )
              //           : (exameAnalysisController.studentReport.isEmpty)
              //               ? Center(
              //                   child: Text(
              //                     "No data available",
              //                     style: TextStyle(
              //                       fontSize: 16.sp,
              //                       fontWeight: FontWeight.w600,
              //                       color: Colors.grey,
              //                     ),
              //                   ),
              //                 )
              //               : barchartForSingleExam(context)
              //       : exameAnalysisController.showloader.value
              //           ? Center(
              //               child: CircularProgressIndicator(),
              //             )
              //           : (exameAnalysisController.singleExamDataList.isEmpty)
              //               ? Center(
              //                   child: Text(
              //                     "No data available",
              //                     style: TextStyle(
              //                       fontSize: 16.sp,
              //                       fontWeight: FontWeight.w600,
              //                       color: Colors.grey,
              //                     ),
              //                   ),
              //                 )
              //               : lineCartGraphWidget(context),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
