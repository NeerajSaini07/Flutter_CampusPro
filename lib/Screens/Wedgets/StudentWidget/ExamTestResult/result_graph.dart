import 'dart:async';

import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/ExamTestResult/scorebar.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/ExamTestResult/subject_in_bottom.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget resultGraph(BuildContext context) {
  final ExamTestExamResultController examResultController =
      Get.find<ExamTestExamResultController>();

  return Obx(
    () => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          controller: examResultController.scrollController,
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.headingcolor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    SizedBox(
                      width: examResultController.testMarksResultList.length <=
                              3
                          ? MediaQuery.of(context).size.width * 1
                          : MediaQuery.of(context).size.width *
                              examResultController.testMarksResultList.length *
                              (MediaQuery.of(context).size.width < 380
                                  ? 0.18.w
                                  : 0.12.w),
                      height: 250.h,
                      child: BarChart(
                        BarChartData(
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
                                reservedSize: 25.w,
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.appbuttonColor),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: bottomListForResultGraph(
                                examResultController.testMarksResultList,
                                context),
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
                          barGroups: examResultController.testMarksResultList
                              .asMap()
                              .entries
                              .map((e) {
                            final index = e.key;
                            final data = e.value;
                            final double studentMarks =
                                double.tryParse(data.maxMarks.toString()) ??
                                    0.0;
                            final double totalMarks =
                                double.tryParse(data.total.toString()) ?? 0.0;

                            final double studentMarksPercentage = double.parse(
                                ((studentMarks / studentMarks) * 100)
                                    .toStringAsFixed(2));
                            final double totalMarksPercentage = double.parse(
                                ((totalMarks / studentMarks) * 100)
                                    .toStringAsFixed(2));

                            return displayescoreWidgets(
                              index,
                              studentMarksPercentage,
                              totalMarksPercentage,
                            );
                          }).toList(),
                          maxY: 100,
                          barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipPadding: const EdgeInsets.all(8),
                              tooltipMargin: 8,
                              tooltipRoundedRadius: 8,
                              fitInsideHorizontally: true,
                              fitInsideVertically: true,
                              getTooltipColor: (group) =>
                                  examResultController.tooltipColor,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                if (groupIndex ==
                                        examResultController
                                            .touchedIndex.value &&
                                    rodIndex ==
                                        examResultController
                                            .touchedRodIndex.value) {
                                  return BarTooltipItem(
                                    'Name: ${examResultController.subjectnameOnTooltip} \nValue: ${rod.toY.toString()}',
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

                                // print(touchedIndex);
                                // print(rodIndex);

                                examResultController.touchedRodIndex.value =
                                    rodIndex;
                                examResultController
                                    .updateTouchedGroupIndex(touchedIndex);
                                examResultController.touchedRodIndex.value =
                                    rodIndex;
                                examResultController
                                        .subjectnameOnTooltip.value =
                                    examResultController
                                        .testMarksResultList[touchedIndex]
                                        .subjectName
                                        .toString();

                                final barGroup = response.spot!.touchedBarGroup;
                                final rod = barGroup.barRods[rodIndex];
                                examResultController.tooltipColor = rod.color!;

                                Timer(const Duration(seconds: 1), () {
                                  examResultController.touchedIndex.value = -1;
                                  examResultController.touchedRodIndex.value =
                                      -1;
                                });
                              } else {
                                examResultController.touchedIndex.value = -1;
                                examResultController.touchedRodIndex.value = -1;
                              }
                            },
                          ),
                        ),
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
        Text(
          "Name Of Subject",
          style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.headingcolor),
        )
      ],
    ),
  );
}
