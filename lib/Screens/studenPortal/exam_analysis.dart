// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/StudentWidget/examAnalysis/line_chart_graph.dart';

class ExameAnalysis extends StatelessWidget {
  const ExameAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final ExameAnalysisController exameAnalysisController =
        Get.find<ExameAnalysisController>();

    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
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
              CustomeHeight(10.h),
              Obx(
                () => (exameAnalysisController.showSingleExamGhraph.value)
                    ? (exameAnalysisController.showloader.value == true)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : barchartForSingleExam(context)
                    : (exameAnalysisController.showloader.value == true)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : lineCartGraphWidget(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
