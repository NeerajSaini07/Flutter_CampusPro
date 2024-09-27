import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'bottom_list.dart';
import 'chart_scrore_data_color_widget.dart';
import 'subject.dart';

Widget lineCartGraphWidget(BuildContext context) {
  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      subjectname(),
      const SizedBox(height: 10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: exameAnalysisController.exannameforAllexamAnalysis.length <= 3
              ? MediaQuery.of(context).size.width * 0.9
              : MediaQuery.of(context).size.width *
                  (exameAnalysisController.exannameforAllexamAnalysis.length) *
                  0.225,
          height: 400.h,
          child: Row(
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  "Student  Marks in All Exam in Percentage (%) ",
                  style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.headingcolor),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 20.h)
                      .copyWith(right: 0),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: List.generate(
                          exameAnalysisController.subjectScoreMap.length,
                          (index) {
                        String subject = exameAnalysisController
                            .subjectScoreMap.keys
                            .elementAt(index);
                        List<double> scores =
                            exameAnalysisController.subjectScoreMap[subject]!;
                        return chartbardata(scores, index, subject);
                      }),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            maxIncluded: true,
                            minIncluded: true,
                            reservedSize: 30.w,
                            interval: 10,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              );
                            },
                          ),
                        ),
                        bottomTitles: bottombarlist(
                            exameAnalysisController.exannameforAllexamAnalysis),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                                getTitlesWidget: (value, meta) {
                                  return const Text(" ");
                                },
                                reservedSize: 40.w,
                                showTitles: true)),
                      ),
                      borderData: FlBorderData(
                        border: Border.all(
                            color: const Color.fromARGB(31, 94, 93, 93)),
                      ),
                      gridData: const FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          verticalInterval: 1,
                          drawHorizontalLine: true),
                      lineTouchData: const LineTouchData(enabled: true),
                      minX: 0,
                      maxX: exameAnalysisController
                              .exannameforAllexamAnalysis.length
                              .toDouble() +
                          1,
                      minY: 0,
                      maxY: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      CustomeHeight(6.h),
      Center(
        child: Text(
          "Student Exam Name ",
          style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.headingcolor),
        ),
      )
    ],
  );
}
