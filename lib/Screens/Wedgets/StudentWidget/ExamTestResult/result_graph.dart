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
                          "Single Exam Marks In Percentage (%)",
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
                      width:
                          examResultController.testMarksResultList.length <= 3
                              ? MediaQuery.of(context).size.width * 1
                              : MediaQuery.of(context).size.width *
                                  (examResultController
                                      .testMarksResultList.length) *
                                  0.200,
                      height: 250.h,
                      child: AspectRatio(
                        aspectRatio: 1.4,
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
                                bottomTitles: bottomListForResultGraph(
                                    examResultController.testMarksResultList),
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
                              barGroups: examResultController
                                  .testMarksResultList
                                  .asMap()
                                  .entries
                                  .map((e) {
                                final index = e.key;
                                final data = e.value;
                                final double studentMarks =
                                    double.tryParse(data.maxMarks.toString()) ??
                                        0.0;
                                final double totalMarks =
                                    double.tryParse(data.total.toString()) ??
                                        0.0;

                                final double studentMarksPercentage =
                                    double.parse(
                                        ((studentMarks / studentMarks) * 100)
                                            .toStringAsFixed(2));
                                final double totalMarksPercentage =
                                    double.parse(
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
                                handleBuiltInTouches: false,
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (group) =>
                                      Colors.transparent,
                                  tooltipMargin: 0,
                                  getTooltipItem: (
                                    BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex,
                                  ) {
                                    return BarTooltipItem(
                                      rod.toY.toString(),
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color,
                                        fontSize: 8.sp,
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          "Student Subject Name",
          style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.headingcolor),
        )
      ],
    ),
  );
}
