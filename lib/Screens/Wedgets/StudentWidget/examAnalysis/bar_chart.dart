// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/examAnalysis/bottom_sheet_subject_name_in_barchart.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'bar_chart_graph.dart';

Widget barchartForSingleExam(BuildContext context) {
  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Student Marks Graph: (${exameAnalysisController.singleExamDataList.first.exam.capitalize})",
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.headingcolor),
      ),
      Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                List.generate(exameAnalysisController.result.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 5.r,
                      backgroundColor: exameAnalysisController
                          .colorplateforsingleexam[index],
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      exameAnalysisController.result[index],
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.appbuttonColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            })),
      ),
      Obx(
        () => SingleChildScrollView(
          controller: exameAnalysisController.scrollController,
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 50.h),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Marks In Percentage (%)",
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.headingcolor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    SizedBox(
                      height: 350.h,
                      width:
                          exameAnalysisController.singleExamDataList.length <= 3
                              ? MediaQuery.of(context).size.width * 0.9
                              : MediaQuery.of(context).size.width *
                                  exameAnalysisController
                                      .singleExamDataList.length *
                                  (MediaQuery.of(context).size.width < 380
                                      ? 0.225
                                      : 0.221),
                      child: AspectRatio(
                        aspectRatio: 1.4,
                        child: BarChart(BarChartData(
                          alignment: BarChartAlignment.spaceBetween,
                          borderData: FlBorderData(
                            border: Border.all(width: 0.1),
                            show: true,
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 30.w,
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    textAlign: TextAlign.left,
                                  );
                                },
                              ),
                            ),
                            bottomTitles: bottom_list_for_barchart(),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            drawHorizontalLine: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                  color: AppColors.appbuttonColor,
                                  strokeWidth: 0.2.w);
                            },
                          ),
                          barGroups: exameAnalysisController.singleExamDataList
                              .asMap()
                              .entries
                              .map((e) {
                            final index = e.key;
                            final data = e.value;
                            final double maxMarks =
                                double.tryParse(data.maxMarks) ?? 0.0;

                            final double marksObtainPercentage = maxMarks > 0
                                ? (double.tryParse(data.marksObtain) ?? 0.0) /
                                    maxMarks *
                                    100
                                : 0.0;

                            final double aveMarksObtainPercentage = maxMarks > 0
                                ? (double.tryParse(data.aveMarksObtain) ??
                                        0.0) /
                                    maxMarks *
                                    100
                                : 0.0;
                            final double obtainmaxmarks = maxMarks > 0
                                ? (double.tryParse(data.maxMarksObtain) ??
                                        0.0) /
                                    maxMarks *
                                    100
                                : 0.0;

                            final double marksObtain = double.parse(
                                marksObtainPercentage.toStringAsFixed(1));
                            final double avgmarksobtain = double.parse(
                                aveMarksObtainPercentage.toStringAsFixed(1));
                            aveMarksObtainPercentage.toStringAsFixed(1);
                            final double maxmarksobtain =
                                double.parse(obtainmaxmarks.toStringAsFixed(1));

                            return displaydata(
                              index,
                              marksObtain,
                              avgmarksobtain,
                              maxmarksobtain,
                            );
                          }).toList(),
                          maxY: 100,
                          barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipPadding: EdgeInsets.all(8),
                              tooltipMargin: 8,
                              tooltipRoundedRadius: 8,
                              fitInsideHorizontally: true,
                              fitInsideVertically: true,
                              getTooltipColor: (group) =>
                                  exameAnalysisController.tooltipColor,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                if (groupIndex ==
                                        exameAnalysisController
                                            .touchedIndex.value &&
                                    rodIndex ==
                                        exameAnalysisController
                                            .touchedRodIndex.value) {
                                  return BarTooltipItem(
                                    'Name: ${exameAnalysisController.subjectnameOnTooltip} \nValue: ${rod.toY.toString()}',
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  );
                                } else {
                                  return null;
                                }
                              },
                            ),
                            touchCallback: (FlTouchEvent event,
                                BarTouchResponse? response) {
                              if (response != null &&
                                  response.spot != null &&
                                  !event.isInterestedForInteractions) {
                                final touchedIndex =
                                    response.spot!.touchedBarGroupIndex;
                                final rodIndex =
                                    response.spot!.touchedRodDataIndex;
                                exameAnalysisController
                                    .updateTouchedGroupIndex(touchedIndex);
                                exameAnalysisController.touchedRodIndex.value =
                                    rodIndex;

                                exameAnalysisController
                                        .subjectnameOnTooltip.value =
                                    exameAnalysisController
                                        .singleExamDataList[touchedIndex]
                                        .subjectName;

                                final barGroup = response.spot!.touchedBarGroup;

                                final rod = barGroup.barRods[rodIndex];

                                exameAnalysisController.tooltipColor =
                                    rod.color!;

                                Timer(Duration(seconds: 1), () {
                                  exameAnalysisController.touchedIndex.value =
                                      -1;
                                  exameAnalysisController
                                      .touchedRodIndex.value = -1;
                                });
                              } else {
                                exameAnalysisController.touchedIndex.value = -1;
                                exameAnalysisController.touchedRodIndex.value =
                                    -1;
                              }
                            },
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Text(
        "Name Of Subject",
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.headingcolor),
      )
    ],
  );
}
